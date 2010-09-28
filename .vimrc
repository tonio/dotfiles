filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

" Security
set modelines=0

" Tab/spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Backups
set backupdir=./.tmp,.,/tmp
set directory=./.tmp,/tmp


" User Interface
set guioptions-=T
set guioptions-=r
syntax on
set bg=dark
set number
set listchars=tab:▸\ ,eol:¬
set shortmess+=r
set showmode
set showcmd
" colorscheme molokai

" Leader
let mapleader=','

" commands
set history=50
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full

" have the mouse enabled all the time:
set mouse=a

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

" Bépo specifid
noremap é w
noremap É W

" Insert <Tab> or complete identifier
" if the cursor is after a keyword character
function MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
         return "\<tab>"
    else
         return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

" svn blame of selection
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" insentive search unless case differences in search terms

" allow switch buffer with modified content without prompt
set hidden

" JSLint
map <F3> :JSLint<CR>
map <F4> :JSLintLight<CR>
map <F5> :JSLintClear<CR>

" Hidden chars
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Special filetype conf
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.less setfiletype less
au BufNewFile,BufRead *.map         setf map

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

" Open file in the same directory as current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
