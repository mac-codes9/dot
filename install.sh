#!/bin/sh
pre_install() {
  $1 update
  yes | $1 upgrade
  $1 install -y yq git
} 

clone_config() {
  cd && mkdir .config
  cd .config
  git init .  
  git remote add origin https://github.com/mac-codes9/dot  
  git pull origin master
  ln -s vim/vimrc ~/.vimrc
  ln -s zsh/zshrc ~/.zshrc
  git config --global user.email $(yq e '.user.name' config.yml)
  git config --global user.name $(yq e '.user.email' config.yml)
}

install_tools() {
  yq e '.tools.all.packages[]' config.yml | xargs $1 install -y
  yq e '.tools.all.node[]' config.yml | xargs npm install -g
  yes | pkg upgrade
}
 
if [ -d "$HOME/.termux" ]; then
  pre_install(pkg) 
  clone_config
  install_tools(pkg)
fi

curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s zsh
