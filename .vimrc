syntax on
set nu
set shiftwidth=2
set tabstop=2

call plug#begin()
 Plug 'sheerun/vim-polyglot'
 Plug 'easymotion/vim-easymotion'
 Plug 'github/copilot.vim'
call plug#end()

nmap s <Plug>(easymotion-overwin-f)
