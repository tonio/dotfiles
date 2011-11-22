" Pathogen {{{
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on
" }}}

" Globals {{{
set nocompatible
set modelines=0
set mouse=a
set autoread
set ttyfast
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,.svn,*.pyc
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

" Statusline {{{
    " Functions {{{
        " Statusline updater {{{
            " Inspired by StatusLineHighlight by Ingo Karkat
            function! s:StatusLine(new_stl, type, current)
                let current = (a:current ? "" : "NC")
                let type = a:type
                let new_stl = a:new_stl

                " Prepare current buffer specific text
                " Syntax: <CUR> ... </CUR>
                let new_stl = substitute(new_stl, '<CUR>\(.\{-,}\)</CUR>', (a:current ? '\1' : ''), 'g')

                " Prepare statusline colors
                " Syntax: #[ ... ]
                let new_stl = substitute(new_stl, '#\[\(\w\+\)\]', '%#StatusLine'.type.'\1'.current.'#', 'g')

                if &l:statusline ==# new_stl
                    " Statusline already set, nothing to do
                    return
                endif

                if empty(&l:statusline)
                    " No statusline is set, use my_stl
                    let &l:statusline = new_stl
                else
                    " Check if a custom statusline is set
                    let plain_stl = substitute(&l:statusline, '%#StatusLine\w\+#', '', 'g')

                    if &l:statusline ==# plain_stl
                        " A custom statusline is set, don't modify
                        return
                    endif

                    " No custom statusline is set, use my_stl
                    let &l:statusline = new_stl
                endif
            endfunction
        " }}}
        " Color dict parser {{{
            function! s:StatusLineColors(colors)
                for type in keys(a:colors)
                    for name in keys(a:colors[type])
                        let colors = {'c': a:colors[type][name][0], 'nc': a:colors[type][name][1]}
                        let type = (type == 'NONE' ? '' : type)
                        let name = (name == 'NONE' ? '' : name)

                        if exists("colors['c'][0]")
                            exec 'hi StatusLine'.type.name.' ctermbg='.colors['c'][0].' ctermfg='.colors['c'][1].' cterm='.colors['c'][2]
                        endif

                        if exists("colors['nc'][0]")
                            exec 'hi StatusLine'.type.name.'NC ctermbg='.colors['nc'][0].' ctermfg='.colors['nc'][1].' cterm='.colors['nc'][2]
                        endif
                    endfor
                endfor
            endfunction
        " }}}
    " }}}
    " Default statusline {{{
        let g:default_stl  = ""
        let g:default_stl .= "<CUR>#[Mode] %{&paste ? 'PASTE  ' : ''}%{substitute(mode(), '', '', 'g')} #[ModeS]</CUR>"
        let g:default_stl .= "#[ModFlag]%{&readonly ? 'RO ' : ''}" " RO flag
        let g:default_stl .= " #[FileName]%f " " File name
        let g:default_stl .= "#[ModFlag]%(%M %)" " Modified flag
        let g:default_stl .= "#[BufFlag]%(%H%W %)" " HLP,PRV flags
        let g:default_stl .= "#[FileNameS]" " Separator
        let g:default_stl .= "#[FileType] %{strlen(&ft) ? &ft : 'n/a'}" " File type
        let g:default_stl .= "#[FunctionName] " " Padding/HL group
        let g:default_stl .= "%<" " Truncate right
        let g:default_stl .= "%= " " Right align
        let g:default_stl .= "<CUR>#[FileFormat]%{&fileformat} </CUR>" " File format
        let g:default_stl .= "<CUR>#[FileEncoding]%{(&fenc == '' ? &enc : &fenc)} </CUR>" " File encoding
        let g:default_stl .= "#[LinePercentS] #[LinePercent]%02(%p%)%% " " Line/column/virtual column, Line percentage
        let g:default_stl .= "#[LineNumberS] #[LineNumber]%03(%l%)#[LineColumn]:%03(%c%) " " Line/column/virtual column, Line percentage
        let g:default_stl .= "%{exists('g:synid') && g:synid ? ' '.synIDattr(synID(line('.'), col('.'), 1), 'name').' ' : ''}" " Current syntax group
    " }}}
    " Color dict {{{
        let s:statuscolors = {
            \   'NONE': {
                \   'NONE'         : [[ 236, 231, 'bold'], [ 232, 244, 'none']]
            \ }
            \ , 'Normal': {
                \   'Mode'         : [[ 214, 235, 'bold'], [                 ]]
                \ , 'ModeS'        : [[ 214, 240, 'bold'], [                 ]]
                \ , 'Branch'       : [[ 240, 250, 'none'], [ 234, 239, 'none']]
                \ , 'BranchS'      : [[ 240, 246, 'none'], [ 234, 239, 'none']]
                \ , 'FileName'     : [[ 240, 231, 'bold'], [ 234, 244, 'none']]
                \ , 'FileNameS'    : [[ 240, 236, 'bold'], [ 234, 232, 'none']]
                \ , 'Error'        : [[ 240, 202, 'bold'], [ 234, 239, 'none']]
                \ , 'ModFlag'      : [[ 240, 196, 'bold'], [ 234, 239, 'none']]
                \ , 'BufFlag'      : [[ 240, 250, 'none'], [ 234, 239, 'none']]
                \ , 'FunctionName' : [[ 236, 247, 'none'], [ 232, 239, 'none']]
                \ , 'FileFormat'   : [[ 236, 244, 'none'], [ 232, 239, 'none']]
                \ , 'FileEncoding' : [[ 236, 244, 'none'], [ 232, 239, 'none']]
                \ , 'Separator'    : [[ 236, 242, 'none'], [ 232, 239, 'none']]
                \ , 'FileType'     : [[ 236, 248, 'none'], [ 232, 239, 'none']]
                \ , 'LinePercentS' : [[ 240, 236, 'none'], [ 234, 232, 'none']]
                \ , 'LinePercent'  : [[ 240, 250, 'none'], [ 234, 239, 'none']]
                \ , 'LineNumberS'  : [[ 252, 240, 'bold'], [ 234, 234, 'none']]
                \ , 'LineNumber'   : [[ 252, 236, 'bold'], [ 234, 244, 'none']]
                \ , 'LineColumn'   : [[ 252, 240, 'none'], [ 234, 239, 'none']]
            \ }
            \ , 'Insert': {
                \   'Mode'         : [[ 153,  23, 'bold'], [                 ]]
                \ , 'ModeS'        : [[ 153,  31, 'bold'], [                 ]]
                \ , 'Branch'       : [[  31, 117, 'none'], [                 ]]
                \ , 'BranchS'      : [[  31, 117, 'none'], [                 ]]
                \ , 'FileName'     : [[  31, 231, 'bold'], [                 ]]
                \ , 'FileNameS'    : [[  31,  24, 'bold'], [                 ]]
                \ , 'Error'        : [[  31, 202, 'bold'], [                 ]]
                \ , 'ModFlag'      : [[  31, 196, 'bold'], [                 ]]
                \ , 'BufFlag'      : [[  31,  75, 'none'], [                 ]]
                \ , 'FunctionName' : [[  24, 117, 'none'], [                 ]]
                \ , 'FileFormat'   : [[  24,  75, 'none'], [                 ]]
                \ , 'FileEncoding' : [[  24,  75, 'none'], [                 ]]
                \ , 'Separator'    : [[  24,  37, 'none'], [                 ]]
                \ , 'FileType'     : [[  24,  81, 'none'], [                 ]]
                \ , 'LinePercentS' : [[  31,  24, 'none'], [                 ]]
                \ , 'LinePercent'  : [[  31, 117, 'none'], [                 ]]
                \ , 'LineNumberS'  : [[ 117,  31, 'bold'], [                 ]]
                \ , 'LineNumber'   : [[ 117,  23, 'bold'], [                 ]]
                \ , 'LineColumn'   : [[ 117,  31, 'none'], [                 ]]
            \ }
        \ }
    " }}}
" }}}

" Statusline highlighting {{{
augroup StatusLineHighlight
    autocmd!

    let s:round_stl = 0

    au ColorScheme * call <SID>StatusLineColors(s:statuscolors)
    au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 1)
    au BufLeave,BufWinLeave,WinLeave,CmdwinLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 0)
    au InsertEnter,CursorHoldI * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Insert', 1)
augroup END
" }}}

" User Interface {{{
set guioptions-=T
set guioptions-=r
syntax on
set bg=dark
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
" }}}

" Folding {{{

" Folding methods {{{
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

" Abbreviations {{{
" Typos
ab calss class
ab hig highlight
" }}}
