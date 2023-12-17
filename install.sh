#!/bin/sh
clone_config() {
  cd
  git config --global user.email $(yq e '.user.name' config.yml)
  git config --global user.name $(yq e '.user.email' config.yml)
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
vim +PlugInstall +qall

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
zsh -c "source ~/.zshrc && zplug update && zplug install && zplug load"
while [ ! -f ~/.zplug/init.zsh -o ! -f ~/.zplug/cache/defer_3_plugin.zsh ]; do
  sleep 1
done
zsh -c "source ~/.zshrc && zplug update && zplug install && zplug load"
chsh -s zsh
