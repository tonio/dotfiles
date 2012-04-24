" Pathogen {{{
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on
" }}}

" Globals {{{
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
set nocompatible
set modelines=0
set mouse=a
set autoread
set ttyfast
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,.svn,*.pyc
set wildignore+=*/.git/*,*/.svn/*
set hidden
set switchbuf=usetab,newtab
" }}}

" Tab/spaces {{{
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
" }}}

" Backups {{{
if v:version >= 703
    set undofile
    set undodir=./.tmp,/tmp
else
    let g:gundo_disable = 1
endif
set backupdir=./.tmp,.,/tmp
set directory=./.tmp,/tmp
set history=500
set undolevels=500
" }}}

" User Interface {{{
set guioptions-=T
set guioptions-=r
syntax on
set bg=dark
set number
if v:version >= 703
    set relativenumber
    set cc=80
endif
set listchars=tab:▸\ ,eol:¬,trail:·
set shortmess+=r
set showmode
set showcmd
set showmatch
set t_Co=256
colorscheme molokai
hi ColorColumn ctermbg=234
if has('gui_running')
    set guifont=Menlo:h12
    set go-=m
endif
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'fancy'
" }}}

" Leader {{{
let mapleader=','
" }}}

" Search {{{
set incsearch
set hlsearch
set nowrap
set shiftround
set autoindent
set ignorecase
set smartcase
set gdefault
" PulseCursorLine
nnoremap n nzzzv:call PulseCursorLine()<cr>
nnoremap N Nzzzv:call PulseCursorLine()<cr>
" }}}

" Text {{{
set formatoptions-=t
set textwidth=79
" }}}

" Scroll {{{
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
" }}}

" Fn keys mapping {{{
" Get out of <esc>
inoremap gq <esc>
inoremap <esc> <nop>
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
nnoremap <F3> :GundoToggle<CR>
nnoremap <silent> <F4> :YRShow<cr>
inoremap <silent> <F4> <ESC>:YRShow<cr>
nnoremap <F5> :execute 'set ' . (&relativenumber ? 'number' : 'relativenumber') <CR>
" }}}

" Yankring {{{
let g:yankring_max_history = 10
let g:yankring_max_element_length = 512000
let g:yankring_history_file = '.vim_yankring_history'
" }}}

" Bépo specific {{{
noremap é w
noremap É W
noremap è bbbe
" }}}

" Insert <Tab> or complete identifier {{{
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
" }}}

" Autocommands {{{
"
" Jumps to the last known position in a file , if the '"' mark is set:
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Save when losing focus
au FocusLost * :wa

" }}}

" Special filetype conf {{{
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
au FileType html setlocal textwidth=0
au BufNewFile,BufRead *.less setf less
au BufNewFile,BufRead *.map setf map
au BufNewFile,BufRead *.tmux.conf setf tmux
au BufNewFile,BufRead *.pp setf puppet
au BufNewFile,BufRead *.penta setf pentadactyl
au BufNewFile,BufRead .pentadactylrc setf pentadactyl
" }}}

" Execute function preserving state {{{
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
" }}}

" Utilities {{{

" Disable highlight
map <leader><space> :noh<cr>

" Hidden chars
nmap <leader>l :set list!<CR>

" remap Y to follow same principle as C, D
noremap Y y$

" Remove trailing spaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Indent whole file
nmap _= :call Preserve("normal gg=G")<CR>

" Order CSS properties
nnoremap <leader>S ?{<CR>jV/}$<CR>k:sort<CR>:noh<CR>

" Quicker window switching
nnoremap <leader>, <c-w><c-w>

" ack-grep word under cursor
noremap <leader># "ayiw:Ack <c-r>a<CR>

" Tabularize
noremap <leader>: :Tabularize /:<cr>
noremap <leader>= :Tabularize /=<cr>
noremap <leader>o vi{:Tabularize /:<cr>

" Select previous selection
nmap gV `[v`[

" Surround shortcut
nmap <leader>é ysiw

" Sudo save
cmap w!! w !sudo tee % >/dev/null

" From tab to vsplit
nnoremap <c-w>V mAZZ<c-w>v`A

" }}}

" Bubbling {{{
" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv
" }}}

" Fast file opening {{{
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>c :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
let g:ctrlp_working_path_mode=2
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files', 'find %s -type f']
" }}}

" Folding {{{

" Folding methods {{{
set foldmethod=marker
au FileType vim setlocal foldmethod=marker
au FileType css setlocal foldmethod=marker
au FileType pentadactyl setlocal foldmethod=marker
au BufNewFile,BufRead *.css  setlocal foldmarker={,}
au FileType javascript setlocal foldmethod=marker
au FileType javascript setlocal foldmarker={,}
au FileType html setlocal foldmethod=manual
" }}}

nnoremap   za
vnoremap   za

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}

" Pulse {{{
function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#2a2a2a ctermbg=233
    redraw
    sleep 20m

    hi CursorLine guibg=#333333 ctermbg=235
    redraw
    sleep 20m

    hi CursorLine guibg=#3a3a3a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#444444 ctermbg=239
    redraw
    sleep 20m

    hi CursorLine guibg=#4a4a4a ctermbg=237
    redraw
    sleep 20m

    hi CursorLine guibg=#555555 ctermbg=235
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

" }}}

" Abbreviations & commands {{{
" Typos
ab calss class
ab hig highlight
" Commands
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
" }}}

" Firefox Reload (UX) ---------------------------------------------------- {{{
function! UXReload()
python << EOF
from subprocess import call
browser = """
tell application "Firefox UX Nightly"
    activate
    tell application "System Events" to keystroke "r" using command down
end tell
"""
call(['osascript', '-e', browser])
EOF
endfunction
noremap <leader>r :call UXReload()<cr>
" }}}
