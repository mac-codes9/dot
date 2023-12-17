#!/bin/sh
clone_config() {
  cd
  git init .
  git remote add origin https://github.com/mac-codes9/dot
  git pull origin master 
}

if [ -d "$HOME/.termux" ]; then
  termux-setup-storage
  pkg update
  yes | pkg upgrade
  pkg install -y yq git
  rm -rf ~/.termux
  clone_config
  yq e '.tools.common' config.yml | xargs -n1 pkg install -y
  yes | pkg upgrade
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

sleep 5

zsh -c "source ~/.zshrc && zplug install && zplug load"
vim +PlugInstall +qall

git config --global user.email $(yq e '.user.name' config.yml)
git config --global user.name $(yq e '.user.email' config.yml)

chsh -s zsh
