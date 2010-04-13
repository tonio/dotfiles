" * User Interface

" have syntax highlighting in terminals which can display colours:
syntax on

" have fifty lines of command-line (etc) history:
set history=50
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
set mouse=a

" auto update on external modification
set autoread
" fast
set ttyfast
" highlight on search
set incsearch
set hlsearch

" don't make it look like there are line breaks where there aren't:
set nowrap

" use indents of 2 spaces, and have them copied down lines:
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround
set expandtab
set autoindent


" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79
set bg=dark
set number

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" source bin/vim-symfony/symfony.vim
"
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>

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

" php man pages
set showmatch
set keywordprg=pman

" svn blame of selection
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" uncutable space for Esc equivalent
inoremap <S-Space> <Esc>

" insentive search unless case differences in search terms
set ignorecase
set smartcase

" allow switch buffer with modified content without prompt
set hidden

" Run JSLint on the current file in simple mode when <F4> is pressed.
map <F4> :JSLintLight<CR>

" Run JSLint on the current file with quickfix when <F5> is pressed.
map <F5> :JSLint<CR>

" Mapserver config file
au BufNewFile,BufRead *.map         setf map
