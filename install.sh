#!/bin/sh
clone_config() {
  cd
  git init .  
  git remote add origin https://github.com/mac-codes9/dot  
  git pull origin master 
  git config --global user.email $(yq e '.user.name' config.yml)
  git config --global user.name $(yq e '.user.email' config.yml)
}

if [ -d "$HOME/.termux" ]; then
  pkg update
  yes | pkg upgrade
  pkg install -y yq git
  rm -rf ~/.termux
  clone_config
  yq e '.tools.all.common[]' config.yml | xargs pkg install -y
  yq e '.tools.all.node[]' config.yml | xargs npm install -g
  yes | pkg upgrade
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
 
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s zsh
