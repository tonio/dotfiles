" Plug =================================================================== {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'neomake/neomake'

call plug#end()
" }}}


" UI ===================================================================== {{{
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme solarized
set cc=80
set cursorline

set number
set relativenumber
" ——— Lightline ========================================================== {{{
let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component': {
	\   'readonly': '%{&filetype=="help"?"":&readonly?"×":""}',
	\   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
	\ },
	\ 'component_visible_condition': {
	\   'readonly': '(&filetype!="help"&& &readonly)',
	\   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '|', 'right': '|' }
	\ }
" ——— }}}

" }}}


" Leader ================================================================= {{{
let mapleader=','
" }}}

" Editor Config ========================================================== {{{
set expandtab
set tabstop=2
set shiftwidth=2
" }}}

" Basic mappings ========================================================= {{{
inoremap gq <esc>

" Browsing
nnoremap é gT
nnoremap è gt

" Reload file
nnoremap <leader>r :e!<CR>

" Find files
nnoremap <leader>c :FZF<CR>
nmap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
nmap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
nmap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
set wildmode=list:longest,full

" Search
set hlsearch
set ignorecase
set gdefault
map <leader><space> :noh<cr>:call clearmatches()<cr>

" Move
nmap   <C-w><C-w>

" Go to changes
nmap » ]c
nmap « [c

" }}}
"
"
" Deoplete =============================================================== {{{
let g:deoplete#enable_at_startup = 1
" == tab to cycle
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"}}}

" Backups ================================================================ {{{
let s:dir = '~/Library/Vim'

if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif

set undofile
" }}}

" Abbreviations & commands ================================================{{{
ab calss class
ab hig highlight

command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
" }}}

" NeoMake ================================================================ {{{
let g:neomake_javascript_enabled_makers = ['standard']
function! neomake#makers#ft#javascript#standard()
  return {
        \ 'args': ['--parser', 'babel-eslint'],
        \ 'errorformat': '%E%f:%l:%c: %m'
        \ }
endfunction
" }}}

" FileTypes ============================================================== {{{
au BufNewFile,BufRead *.es6 setf javascript
" }}}
