" Plug =================================================================== {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'airblade/vim-gitgutter'
Plug 'ericpruitt/tmux.vim', {'rtp': 'vim/'}
Plug 'lifepillar/vim-solarized8'
Plug 'godlygeek/tabular'
Plug 'isRuslan/vim-es6'
Plug 'itchyny/lightline.vim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lfv89/vim-interestingwords'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'sophacles/vim-bundle-mako'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'flowtype/vim-flow'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'docunext/closetag.vim'
Plug 'janko/vim-test'
Plug 'evanleck/vim-svelte'
Plug 'codechips/coc-svelte', {'do': 'npm install'}
Plug 'github/copilot.vim'
Plug 'Yggdroot/indentLine'
Plug 'psliwka/vim-smoothie'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'alvarosevilla95/luatab.nvim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'wellle/targets.vim'
Plug 'posva/vim-vue'
Plug 'yaegassy/coc-volar', { 'do': 'yarn install --frozen-lockfile' } " VueJS
Plug 'yaegassy/coc-volar-tools', { 'do': 'yarn install --frozen-lockfile' }

Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'greggh/claude-code.nvim'


call plug#end()
" }}}

" UI ===================================================================== {{{
let &bg = system('gsettings get org.gnome.desktop.interface color-scheme') =~ 'dark' ? 'dark' : 'light'
set termguicolors
let g:solarized_contrast = "normal"
let g:solarized_visibility= "normal"
colorscheme solarized8
set cc=80
set cursorline
hi htmlArg gui=italic
hi TabLine ctermbg=None
set cmdheight=0

lua << EOF
require('luatab').setup{ windowCount = function() return '' end }
EOF

set number
set relativenumber
set mouse=

" Lightline
source ~/.config/nvim/lightline.vim

" GitGutter
let g:gitgutter_diff_args = '-w'



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
tnoremap <esc> <C-\><C-n>

" Browsing
nnoremap é gT
nnoremap è gt

" Reload file
nnoremap <leader>r :e!<CR>

" Find files
nmap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
nmap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
nmap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
set wildmode=list:longest,full

" File statistics
nmap <leader>s g<C-G>

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

" Surround
nmap <leader>é ysiw

" XML Lint
nmap <leader>x :%!xmllint --format --recover -<cr>

" Emmet
let g:user_emmet_leader_key='<C-E>'

" Test
let test#strategy = "neovim"
nmap <leader>t :TestNearest<cr>

" }}}

" Noice ================================================================== {{{
lua require("noice").setup()
" }}}

" Claude ================================================================= {{{
lua require("claude-code").setup()
" }}}

" Coc ==================================================================== {{{
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <leader>qf  <Plug>(coc-codeaction)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
"}}}

" Backups ================================================================ {{{
set undofile
" }}}

" Abbreviations & commands ================================================{{{
ab calss class

command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
" }}}

" ALE ==================================================================== {{{
nnoremap <leader>F :ALEFix<CR>
" Without this, ALE adds its default linters (incl. tsserver) for any filetype
" absent from g:ale_linters, duplicating the language server coc already runs.
let g:ale_linters_explicit = 1
let g:ale_linters = { 'javascript': ['prettier'], 'css': ['stylelint'], 'python': ['black'], 'scss': ['prettier'], 'html': ['prettier'], 'svelte': ['prettier'], 'vue': ['prettier'] }
let g:ale_fixers = { 'javascript': ['prettier'], 'css': ['stylelint'], 'typescript': ['prettier'], 'html': ['prettier'], 'less': ['prettier'], 'scss': ['prettier'], 'python': ['black'], 'svelte': ['prettier', 'eslint'] , 'vue': ['prettier', 'eslint']}
let g:ale_open_list = 0
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
" }}}

" Telescope ============================================================== {{{
nnoremap <leader>c <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap à <cmd>Telescope buffers<cr>
nnoremap <leader>n <cmd>Telescope notify<cr>
" }}}
