syntax on
set nu shiftwidth=2 tabstop=2

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
  
call plug#begin()
 Plug 'easymotion/vim-easymotion'
 Plug 'junegunn/vim-plug'
 Plug 'github/copilot.vim'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'sheerun/vim-polyglot'
call plug#end()

nmap s <Plug>(easymotion-overwin-f)
nmap f :Files<cr>
