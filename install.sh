if [ -d "$HOME/.termux" ]; then
	pkg add git vim zsh
fi
chsh -s $(which zsh)

git clone https://github.com/mac-codes9/dot
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

zsh -c "source ~/.zshrc; zplug install; zplug load"
zsh -c "vim +PlugInstall +qall"
