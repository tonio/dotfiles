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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'neomake/neomake'
Plug 'mattn/emmet-vim'
Plug 'sophacles/vim-bundle-mako'
Plug 'godlygeek/tabular'
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'lfv89/vim-interestingwords'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'isRuslan/vim-es6'
Plug 'ruanyl/vim-caniuse'

call plug#end()
" }}}

" Python ================================================================= {{{
let g:python3_host_prog = '/home/aabt/.virtualenvs/neovim/bin/python3'
" }}}

" UI ===================================================================== {{{
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme solarized
set cc=80
set cursorline

set number
set relativenumber

" Lightline
source ~/.config/nvim/lightline.vim

" GitGutter
let g:gitgutter_diff_args = '-w'

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

" Live preview
set inccommand=split

" Copy
hi HighlightedyankRegion cterm=reverse gui=reverse

" Move
nmap   <C-w><C-w>

" Go to changes
nmap » ]c
nmap « [c

" Follow link
nmap <leader>d <c-]>

" Tabularize
noremap <leader>: :Tabularize /:<cr>
noremap <leader>= :Tabularize /=<cr>
noremap <leader>o vi{:Tabularize /:<cr>

" Goyo
noremap <leader>g :Goyo<cr>

" Surround
nmap <leader>é ysiw

" XML Lint
nmap <leader>x :%!xmllint --format --recover -<cr>

" Emmet
let g:user_emmet_leader_key='<C-E>'

" }}}


" Deoplete =============================================================== {{{
let g:deoplete#enable_at_startup = 1
" == tab to cycle
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"}}}

" Backups ================================================================ {{{
let s:dir = '~/Library/Vim'
if isdirectory(expand(s:dir))
  let &directory = expand(s:dir) . '/swap/,' . &directory
  let &backupdir = expand(s:dir) . '/backup/,' . &backupdir
  let &undodir = expand(s:dir) . '/undo/,' . &undodir
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
        \ 'args': ['--parser', 'babel-eslint']
        \ }
endfunction

nnoremap <leader>m :Neomake<CR>
nnoremap <leader>M :Neomake!<CR>
" }}}

" FileTypes ============================================================== {{{
au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead *.coffee setf javascript
" autocmd bufwritepost *.es6 silent !standard --fix %
" }}}
