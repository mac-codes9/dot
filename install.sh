if [ -d "$HOME/.termux" ]; then
  pkg update; pkg add yq git
  git clone --force https://github.com/mac-codes9/dot .
  yq e '.tools.common' config.yml | xargs -n1 pkg install -y
fi

chsh -s $(which zsh)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

zsh -c "source ~/.zshrc; zplug install; zplug load"
zsh -c "vim +PlugInstall +qall"
