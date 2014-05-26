" Pathogen ----------------------------------------------------------------{{{
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on
" Airline
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#close_symbol = 'X'
" Gist
let g:gist_get_multiplefile = 1
" }}}

" Globals -----------------------------------------------------------------{{{
set nocompatible
set modelines=0
set mouse=a
set ttyfast
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,.svn,*.pyc
set wildignore+=*/.git/*,*/.svn/*
set hidden
set switchbuf=usetab,newtab
" }}}

runtime bundle/matchit/plugin/matchit.vim

" Tab/spaces --------------------------------------------------------------{{{
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
" }}}

" Backups -----------------------------------------------------------------{{{
if v:version < 703
    let g:gundo_disable = 1
endif
set undolevels=500
" }}}

" User Interface ----------------------------------------------------------{{{
set guioptions-=T
set guioptions-=r
syntax on
set bg=light
set number
set relativenumber
set cc=80
set list
set shortmess+=r
set t_Co=256
" Solarized ---------------------------------------------------------------{{{
" let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_constrast = "high"
colorscheme solarized
" }}}
" colorscheme molokai
if has('gui_running')
    set guifont=PragmataPro\ for\ Powerline:h12
    set go-=m
endif
set cursorline
set encoding=utf-8
set noshowmode
hi clear SignColumn
hi SignColumn ctermbg=15
" }}}

" Leader {{{
let mapleader=','
" }}}

" Search {{{
set hlsearch
set nowrap
set ignorecase
set gdefault
nnoremap n nzz
nnoremap N Nzz
" }}}

" Text {{{
set formatoptions-=t
set textwidth=79
" }}}

" Fn keys mapping {{{
" Get out of <esc>
inoremap gq <esc>
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
nnoremap <F3> :GundoToggle<CR>
nnoremap <F4> :set norelativenumber<CR>:set nonumber<CR>
nnoremap <F5> :set relativenumber<CR>:set number<CR>
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
" Jumps to the last known position in a file , if the '"' mark is set:
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" Special filetype conf {{{
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
au FileType html setlocal textwidth=0
au BufNewFile,BufRead *.less setf less
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
map <leader><space> :noh<cr>:call clearmatches()<cr>

" Hidden chars
nmap <leader>l :set list!<CR>

" Remove trailing spaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Indent whole file
nmap _= :call Preserve("normal gg=G")<CR>

" Order CSS properties
nnoremap <leader>S ?{<CR>jV/}$<CR>k:sort<CR>:noh<CR>

" Quicker window switching
nnoremap <leader>, <c-w><c-w>

" ack-grep word under cursor
let g:ackprg="ack-grep -H --nocolor --nogroup --column --ignore-dir=buildout --ignore-dir=build"
noremap <leader># "ayiw:Ack <c-r>a<CR>

" Tabularize
noremap <leader>: :Tabularize /:<cr>
noremap <leader>= :Tabularize /=<cr>
noremap <leader>o vi{:Tabularize /:<cr>

" Select previous selection
nmap gV `[v`]
vmap Y y`]

" Expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Surround shortcut
nmap <leader>é ysiw

" insert 1 char
nnoremap <space> :<C-U>call InsertChar#insert(v:count1)<CR>

" Reload file
nnoremap <leader>r :e!<CR>

" Sudo save
cmap w!! w !sudo tee % >/dev/null

" From tab to vsplit
nnoremap <c-w>V mAZZ<c-w>v`A

" }}}

" Zencoding {{{
let g:user_zen_settings = {'indentation' : '    '}
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
au FileType vim setlocal foldlevel=1
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

" Abbreviations & commands ------------------------------------------------{{{
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


" Highlight Word --------------------------------------------------------- {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily. You can search for it, but that only
" gives you one color of highlighting. Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz
    " Yank the current word into the z register.
    normal! "zyiw
    " Calculate an arbitrary match ID. Hopefully nothing else is using it.
    let mid = 86750 + a:n
    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)
    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'
    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)
    " Move back to our original location.
    normal! `z
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}
" }}}

" Tags ------------------------------------------------------------------- {{{
noremap <leader>d <c-]>
noremap <leader>gd g<c-]>
" }}}

" Backups ---------------------------------------------------------------- {{{
let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim': '$XDG_DATA_HOME/vim'

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

if exists('+undofile')
  set undofile
endif
" }}}
