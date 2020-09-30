set nocompatible
call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/lightline_foobar.vim'
call plug#end()
set clipboard=unnamedplus
set runtimepath^=/usr/share/vim/vimfiles
set number
syntax on
let mapleader =" "
let g:lightline = {
      \ 'colorscheme': 'neodark_alter',
      \ }
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
set tabstop=2
set autoindent
set expandtab
set softtabstop=2
set incsearch
nmap ; :
map <leader>l :let @/=""<CR>
map <leader>a ggVG<CR>
map <leader>q :tabc<CR>
map <leader>m :tabnew<CR>
map <leader>k :tabn<CR>
map <leader>j :tabp<CR>
map <leader>f :Ex<CR>
map <leader>c :bd<CR>
map <leader>x :set laststatus=0<CR>
map <leader>b :set laststatus=2<CR> 
map Q <nop>
