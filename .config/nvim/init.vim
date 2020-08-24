set nocompatible
call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'
Plug 'vim-jp/vim-cpp'
Plug 'pboettch/vim-cmake-syntax'
Plug 'elzr/vim-json'
Plug 'othree/html5.vim'
Plug 'StanAngeloff/php.vim'
Plug 'vim-python/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'mboughaba/i3config.vim'
Plug 'ap/vim-css-color'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
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
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
set tabstop=2
set autoindent
set expandtab
set softtabstop=2
set incsearch
noremap h h
noremap H H
noremap t j
noremap T J
noremap n k
noremap N K
noremap s l
noremap S L
noremap l n
noremap L N
noremap j t
noremap J T
noremap k s
noremap K S
nmap ; :
nnoremap <C-l> :let @/=""<CR>
map <leader>a ggVG<CR>
map <leader>N :RangerNewTab<CR>
map <leader>n :Ranger<CR>
map <leader>c :tabc<CR>
map <leader>m :tabnew<CR>
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end
