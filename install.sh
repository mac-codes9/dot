#!/bin/sh
installer=''
tools=''

if [ -d "$HOME/.termux" ]; then
  echo "Running on Termux"
  installer=pkg
  tools='tools.all.packages[] + tools.all.zsh.packages[] + tools.all.node[] + tools.mobile.packages[] | join (" ")'
elif [ "$(uname -s)" = "Darwin" ]; then
  echo "Running on macOS"
  installer=brew
  tools='tools.all.packages[] + tools.all.zsh.packages[] + tools.all.node[] + tools.computer.all.packages[] + tools.computer.all.node[] + tools.computer.mac.packages[] | join(" ")'
fi

pre_install() {
  if [ "$installer" = brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  $installer update
  $installer upgrade

  if [ "$installer" = brew ]; then
    $installer install -y yq
  else
    $installer install -y yq git
  fi
}

post_install() {
  mkdir docs
  chsh -s zsh
}

clone_config() {
  cd && mkdir .config
  cd .config
  git init .
  git remote add origin https://github.com/mac-codes9/dot
  git pull origin master
  ln -s ~/.config/vim/vimrc ~/.vimrc
  ln -s ~/.config/zsh/zshrc ~/.zshrc
  cd; git clone https://github.com/mac-codes9/dot.wiki.git notes
}

git_config() {
  git config --global user.email $(yq e 'user.name' config.yml)
  git config --global user.name $(yq e 'user.email' config.yml)
  git config --global push.autoSetupRemote true
}

install_tools() {
  yq e $tools ~/.config/config.yml | xargs $installer install -y
  yq e $tools ~/.config/config.yml | xargs $installer npm install -g
  $installer upgrade
  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

if [ -n "$installer" ]; then
  pre_install
  clone_config
  git_config
  install_tools
  post_install
else 
  echo "No installer set, may be on unsupported environment"
fi

