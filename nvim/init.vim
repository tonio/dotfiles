" Plug =================================================================== {{{
call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'frankier/neovim-colors-solarized-truecolor-only'

call plug#end()
" }}}


" UI ===================================================================== {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme solarized
set cc=80
" }}}


" Leader ================================================================= {{{
let mapleader=','
" }}}


" Basic mappings ========================================================= {{{
inoremap gq <esc>
" == Browsing {{{
nnoremap é gT
nnoremap è gt
" == }}}
" }}}
"
"
" Deoplete =============================================================== {{{
let g:deoplete#enable_at_startup = 1
" == tab to cycle
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" = <cr> to close
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"}}}
