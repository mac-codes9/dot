if [ -d "$HOME/.termux" ]; then
  pkg update; pkg upgrade; pkg add yq git
  rm -rf .termux
  git init .
  git remote add origin https://github.com/mac-codes9/dot
  git pull origin master
  yq e '.tools.common' config.yml | xargs -n1 pkg install -y
  pkg upgrade -y
fi

chsh -s $(which zsh)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

zsh -c "source .zshrc; zplug install; zplug load"
zsh -c "vim +PlugInstall +qall"
