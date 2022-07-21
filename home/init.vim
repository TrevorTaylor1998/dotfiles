filetype plugin indent on
" syntax on
set wildmenu
set wildmode=longest:full,full
set expandtab
set shiftwidth=2
set autoindent
set ignorecase
set hlsearch
set cmdheight=2
set splitbelow splitright
set colorcolumn=80
set cursorline
set number
set relativenumber
set hidden
set completeopt=menuone
set timeoutlen=10000

" AUTOMATION

" delete trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

" change C++ commenting style
autocmd FileType cpp setlocal commentstring=//%s

" change openscad commenting style
autocmd FileType .scad setlocal commentstring=//%s


" MAPPINGS

let mapleader = "\<SPACE>"

" Moving around splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" trying out kj escpae
inoremap kj <ESC>

" change Y to be like D
map Y y$

" remaps
nnoremap U <C-r>
command! W execute "write"

" general
nnoremap <LEADER>wq :wq<CR>
" nmap <LEADER>. <Plug>VinegarUp
nnoremap <LEADER>wq :wq<CR>
nnoremap <LEADER>a  :

" Splits
nnoremap <LEADER>wv :vsplit<CR>
nnoremap <LEADER>ws :split<CR>
nnoremap <LEADER>wh <C-w>h
nnoremap <LEADER>wj <C-w>j
nnoremap <LEADER>wk <C-w>k
nnoremap <LEADER>wl <C-w>l

" yanking and putting
nnoremap <LEADER>yy "+yy
nnoremap <LEADER>pp "+p

" tabs
nnoremap <LEADER>tn :tabf % <CR>
nnoremap <LEADER>tk :tabn <CR>
nnoremap <LEADER>tj :tabp <CR>
nnoremap <LEADER>tc :tabc <CR>


" PLUGINS

" ALE

let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
" let g:ale_linters = {'python': ['flake8'], 'go': ['golint'], 'rust': ['analyzer']}
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'nix': ['nixfmt'],
\}

" let g:ale_go_golangci_lint_options =
set omnifunc=ale#completion#OmniFunc

" Easymotion

let g:EasyMotion_do_mapping = 0

" rust autoformat
 let g:rustfmt_autosave = 1

" let g:syntastic_rust_checkers = ['cargo']
" let g:ale_linters = {
" \  'rust': ['analyzer'],
" \}
let b:ale_fixers = {'rust': ['rustfmt']}

" Vim Slime
let g:slime_target = "tmux"
let g:latex_to_unicode_auto = 1


" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('sources', {
" \ '_': ['ale', 'foobar'],
" \})
