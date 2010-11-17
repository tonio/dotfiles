filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

" Security
set modelines=0

" Tab/spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Backups
if v:version >= 703
    set undofile
    set undodir=./.tmp,/tmp
endif
set backupdir=./.tmp,.,/tmp
set directory=./.tmp,/tmp
set undofile

" User Interface
set guioptions-=T
set guioptions-=r
syntax on
set bg=dark
if v:version >= 703
    set relativenumber
    set cc=80
endif
set listchars=tab:▸\ ,eol:¬
set shortmess+=r
set showmode
set showcmd
set showmatch
set t_Co=256
colorscheme molokai
hi ColorColumn ctermbg=234
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2

" Leader
let mapleader=','

" commands
set history=500
set undolevels=500
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full

" have the mouse enabled all the time:
set mouse=a
set scrolloff=3
set autoread
set ttyfast
set incsearch
set hlsearch
set nowrap
set shiftround
set expandtab
set autoindent
set ignorecase
set smartcase
set gdefault


" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79

nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <F3> GundoToggle<CR>
nnoremap <silent> <F4> :YRShow<cr>
inoremap <silent> <F4> <ESC>:YRShow<cr>

" remap Y to follow same principle as C, D
noremap Y y$

" Bépo specific
noremap é w
noremap É W
noremap è bbbe

" Insert <Tab> or complete identifier
" if the cursor is after a keyword character
function! MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
         return "\<tab>"
    else
         return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

"This autocommand jumps to the last known position in a file
"just after opening it, if the '"' mark is set:
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" svn blame of selection
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" allow switch buffer with modified content without prompt
set hidden

" Hidden chars
nmap <leader>l :set list!<CR>

" Special filetype conf
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au BufNewFile,BufRead *.less setf less
au BufNewFile,BufRead *.map  setf map
au BufNewFile,BufRead .tmux.conf  setf tmux

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Remove trailing spaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Indent whole file
nmap _= :call Preserve("normal gg=G")<CR>

" Order CSS properties
nnoremap <leader>S ?{<CR>jV/}$<CR>k:sort<CR>:noh<CR>

" Sudo save
cmap w!! w !sudo tee % >/dev/null

" Select previous selection
nmap gV `[v`[

" Surround shortcut
nmap <leader>é ysiw

" Change word case
nmap <leader>~ viw~

" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" Open file in the same directory as current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
