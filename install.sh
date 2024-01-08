#!/bin/sh
installer=pkg
install_command='install'
tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.mobile.packages[] | join(" ")'
config=~/.config/config.yml

if [ -f "/etc/os-release" ]; then
  . /etc/os-release
fi

if [ -d "$HOME/.termux" ]; then
  echo "Running on Termux"
elif [ "$(uname -s)" = "Darwin" ]; then
  echo "Running on macOS"
  installer=brew
  tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.computer.all.packages[] + .tools.computer.mac.packages[] | join(" ")'
elif [ "$ID" = "arch" ]; then
  echo "Running on Arch Linux"
  installer=pacman
  install_command='-Syu'
  tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.computer.all.packages[] + .tools.computer.linux.packages[] | join(" ")'
elif [ "$ID" = "ubuntu" ]; then
  echo "Running on Ubuntu"
  installer="sudo apt"
  tools='.tools.all.packages[] + .tools.all.zsh.packages[] + .tools.mobile.packages[] | join(" ")'
else
  echo "Unsupported environment"
  exit
fi

pre_install() {
  if [ "$installer" = brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

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
  "$installer" "$install_command" "$(yq e "$tools" "$config")"

  if [ ! -x "$(command -v curl)" ]; then
    $installer $install_command curl
  fi

  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
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
