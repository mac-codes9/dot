#!/bin/sh
installer='yes | pkg'
install_command="install"
set -- '.all.packages[]' '.all.zsh.packages[]'
tools_config=~/.config/tools.yml

if [ -f "/etc/os-release" ]; then
  . /etc/os-release
fi

if [ -d "$HOME/.termux" ]; then
  echo "Running on Termux"
  set -- "$@" '.mobile[]'
  yes | pkg update
else
  set -- "$@" '.computer.all.packages[]'
  if [ "$(uname -s)" = "Darwin" ]; then
    echo "Running on macOS"
    installer=brew
    set -- "$@" '.computer.mac.packages[]'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ "$ID" = "arch" ]; then
    echo "Running on Arch Linux"
    installer=pacman
    install_command="-Syu"
    set -- "$@" '.computer.linux.packages[]'
  elif [ "$ID" = "ubuntu" ]; then
    echo "Running on Ubuntu"
    installer=apt
    set -- "$@" '.computer.linux.packages[]'
    add-apt-repository ppa:rmescandon/yq
    apt update
  else
    if [ "$1" ]; then
      installer=$1
      echo "Unsupported environment, using specified package manager"
    else
      echo "Unsupported environment, exiting"
      exit
    fi
  fi
fi

pre_install() {
  if [ ! -x "$(command -v git)" ]; then
    $installer $install_command yq git
  else
    $installer $install_command yq
  fi
}

clone_config() {
  cd || exit
  mkdir .config
  cd .config || exit
  git init .
  git remote add origin https://github.com/mac-codes9/dot
  git pull origin master
  ln -s ~/.vim/config ~/.vimrc
  ln -s ~/.zsh/config ~/.zshrc
  ln -s ~/.git/config ~/.gitconfig
  ln -s ~/.git/message ~/.gitmessage
  cd || exit
  git clone https://github.com/mac-codes9/dot.wiki.git notes
}

install_tools() {
  $installer $install_command "$(yq r "$@" "$tools_config")"
  npm install "$(yq e '.node' "$tools_config")"
  cargo install "$(yq e '.cargo' "$tools_config")"

  if [ ! -x "$(command -v curl)" ]; then
    $installer $install_command curl
  fi

  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
}

post_install() {
  mkdir docs
  cd docs || exit
  git clone https://github.com/mac-codes9/portfolio
  if [ "$SHELL" != "/bin/zsh" ]; then
    chsh -s zsh
  fi
}

pre_install
clone_config
install_tools
post_install
