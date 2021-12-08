" _don't be vi
set nocompatible
let g:EasyMotion_do_mapping = 0

" remap leader key
let mapleader = "\<SPACE>"
set timeoutlen=10000

" Autocomplete built in for ale
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc

" Enable syntax and plugins (for netrw)
filetype plugin on

" Display matching files when tab complete
set wildmenu
set wildmode=longest:full,full

" setting up tabs stuff
set expandtab
set shiftwidth=2
set autoindent

" searching stuff
set ignorecase
set hlsearch

" makes term bigger for better linting
set cmdheight=2

" Sets splits to be to the right and left only
set splitbelow splitright

" Set a colorcolumn
set colorcolumn=80

let g:slime_target = "tmux"
:let g:latex_to_unicode_auto = 1

" Usable terminal
:tnoremap nt <C-\><C-n>

" Mappings
" Moving around splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" More Movement
map <C-m> h
" map <C-f> l

" trying out kj escpae
inoremap kj <ESC>

" change Y to be like D
map Y y$

" remaps
nnoremap U <C-r>
command! W execute "write"

" Sets number and relative number
set number
set relativenumber

" buffer
set hidden

" Sets Theme
syntax on
" colorscheme wal

" changing auto complete menu
set completeopt=menuone

" delete trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

" change C++ commenting style
autocmd FileType cpp setlocal commentstring=//%s

" change openscad commenting style
autocmd FileType .scad setlocal commentstring=//%s

" adding in number pad
nmap <M-n> 1
nmap <M-e> 2
nmap <M-i> 3
nmap <M-l> 4
nmap <M-u> 5
nmap <M-y> 6
nmap <M-7> 7
nmap <M-8> 8
nmap <M-9> 9

imap <M-n> 1
imap <M-e> 2
imap <M-i> 3
imap <M-l> 4
imap <M-u> 5
imap <M-y> 6
imap <M-7> 7
imap <M-8> 8
imap <M-9> 9


" general
nnoremap <LEADER>wq :wq<CR>
nmap <LEADER>. <Plug>VinegarUp
nnoremap <LEADER>wq :wq<CR>
nnoremap <LEADER>te :vsplit term://zsh<CR>
nnoremap <LEADER>a  :
" nnoremap <LEADER>gg G
nnoremap <LEADER>pi :PlugInstall <CR>
nnoremap <LEADER>pc :PlugClean <CR>
nnoremap <LEADER>sv :source ~/.config/nvim/init.vim <CR>

" Splits
nnoremap <LEADER>wv :vsplit
nnoremap <LEADER>ws :split

" yanking and putting
nnoremap <LEADER>yy "+yy
nnoremap <LEADER>pp "+p
"
" coding
nnoremap <LEADER>cp :!python3 % <CR>
nnoremap <LEADER>cc :!g++ % && ./a.out <CR>
nnoremap <LEADER>cm :make <CR>
nnoremap <LEADER>ch :!ghc % && ./%:r <CR>

" tabs
nnoremap <LEADER>tn :tabf % <CR>
nnoremap <LEADER>tk :tabn <CR>
nnoremap <LEADER>tj :tabp <CR>
nnoremap <LEADER>tc :tabc <CR>


" easymotion settings
let g:EasyMotion_keys = 'arstneio'
map <LEADER>. <Plug>(easymotion-reapeat)
map <LEADER>f <Plug>(easymotion-overwin-f)
map <LEADER>j <Plug>(easymotion-overwin-line)
map <LEADER>k <Plug>(easymotion-overwin-line)
map <LEADER>w <Plug>(easymotion-overwin-w)
nmap s <Plug>(easymotion-overwin-f2)
" nmap s <Plug>(easymotion-s2)

" latex
" nnoremap <LEADER>ll :!pdflatex %<CR>
" nnoremap <LEADER>le
" i\begin{equation}<ENTER><BACKSPACE><ENTER>\end{equation}<ESC>ki<Tab>
" nnoremap <LEADER>lb
" i\begin{bmatrix}<ENTER><BACKSPACE><ENTER>\end{bmatrix}<ESC>ki<Tab>
" nnoremap <LEADER>lf i\includegraphics[width=\linewidth]{

" julia REPL

nmap <LEADER><LEADER> <Plug>ReplSend_Motion
nmap <C-t> gzz
nmap <LEADER><LEADER> <Plug>ReplSend_Visual


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  -- Modules and its options go here
  highlight = { enable = true },
}
require'lspconfig'.rnix.setup{}
EOF
" require'lspconfig'.haskell-language-server.setup{}
