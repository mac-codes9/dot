syntax on
set nu
set shiftwidth=2
set tabstop=2

call plug#begin()
 Plug 'easymotion/vim-easymotion'
 Plug 'github/copilot.vim'
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'sheerun/vim-polyglot'
call plug#end()

nmap s <Plug>(easymotion-overwin-f)
nmap f :Files<cr>
