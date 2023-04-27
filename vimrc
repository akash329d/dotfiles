"Install plug and plugins if plug isn't installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'

call plug#end()

filetype on
filetype plugin on

set relativenumber

" set tabs to 4 spaces
set ts=4 
" indent when moving to next line
set autoindent

syntax on
colorscheme onedark
