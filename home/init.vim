" nnoremap <silent> <LEADER> :<C-U>LeaderGuide '<SPACE>'<CR>
" vnoremap <silent> <LEADER> :<C-U>LeaderGuideVisual '<SPACE>'<CR>

" autocmd! VimEnter * AnyFoldActivate
" autocmd BufNew * AnyFoldActivate

syntax on

set foldmethod=indent
" don't fold immediately
set foldlevelstart=99


" Fold Cycle
let g:fold_cycle_default_mapping = 0 "disable default mappings
nmap <Tab> <Plug>(fold-cycle-open)
nmap <S-Tab> <Plug>(fold-cycle-close)

" latex stuff

let g:vimtex_view_method = 'zathura'
let g:vimtex_complier_method = 'latexrun'

colorscheme wal

" make the which key window transparent
highlight WhichKeyFloat ctermbg=None
highlight WhichKeyFloat ctermfg=2

" autocmd ColorScheme * highlight WhichKeyFloat None
