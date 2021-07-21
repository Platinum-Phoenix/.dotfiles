" ---------------------------------------------------
" Description:
"   My Vim Configuration
" Author:
"   Phoenix
"

" Section: Vim-Plug --------------------------- {{{

set nocompatible
" I use vim-plug: https://github.com/junegunn/vim-plug
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')"
  " Enhanced syntax highligting
  Plug 'sheerun/vim-polyglot'
  " Color Schemes
  Plug 'arcticicestudio/nord-vim'
  Plug 'drewtempelmeyer/palenight.vim'
  " File browser
  Plug 'preservim/nerdtree'
  Plug 'rust-lang/rust.vim'
  " Autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/tagbar'
  " Prettier status line
  Plug 'itchyny/lightline.vim'

  " Opengl for c
  Plug 'beyondmarc/opengl.vim'

  " I'm making a progamming language ;)
  Plug '~/Documents/Code/Rust/kip-lang/editors/vim'
call plug#end()
" }}}

" Section: Theme ----------------------------------- {{{
set background=dark
colorscheme nord
if has('termguicolors')
  set termguicolors
endif
" }}}


" Section: Essentials ------ {{{
set number relativenumber
set mouse=a
let mapleader=','
let maplocalleader='-'
set laststatus=2
set noshowmode
" searching
set ignorecase smartcase

set foldmethod=syntax
set nofoldenable
set hidden
" More space for error messages
set cmdheight=2
set updatetime=300
" }}}

" Section: Mappings ------------------- {{{
" rebind <esc>
inoremap jk <esc>
" inoremap <esc> <nop>
" move lines up and down
noremap <leader>- ddp
noremap <leader>_ ddkP
noremap <leader><space> za
nnoremap <leader><c-u> vwU<esc>
inoremap <leader><c-u> <esc>vwUi
" easily edit my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" typos
iabbrev waht what
iabbrev tehn then
iabbrev teh the
" util
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" `><esc>a"<esc>`<i"<esc>
nnoremap H 0
nnoremap L $
" convert the previous word to uppercased
" this prevents me from using caps lock
imap GG <esc>bgUiwea
let g:autodoc = 1

" open man page
nnoremap <leader>m :Man<cr>
" nnoremap gb
" }}}

" Section: Status Line ----------------------- {{{
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste'],
      \ [ 'cocstatus', 'readonly', 'filename', 'modified' ]
    \ ]
  \ },
  \ 'component_function': {
    \ 'cocstatus': 'coc#status'
 \ }
\ }
" }}}

" Section: Coc.nvim Configuration ---------------------------------------- {{{
" See: https://github.com/neoclide/coc.nvim#example-vim-configuration
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
 inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                             \: "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of the current 
" buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Applying codeAction to the selected region.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

augroup coc_status
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END
" }}}

" Section: Filetype Configuration -------------------------- {{{
augroup tab_config
  autocmd!
  autocmd FileType c,cpp,objc setlocal expandtab cindent
  " Use an indentation of 2 spaces in xml-like files.
  autocmd FileType html,xhtml,css,xml,xslt setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

  " In Makefiles, don't use tabs (because they are necessary).
  autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" enable spell checking in text and markdown files
augroup spellcheck
  autocmd!
  autocmd filetype text,markdown setlocal spell spelllang=en_us
augroup END

let g:asmsyntax = 'nasm'
let c_no_curly_error = 1
let c_syntax_for_h = 1

augroup assembly
  autocmd!
  autocmd FileType nasm setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 syntax=nasm
  autocmd BufNewFile,BufRead *.asm set filetype=nasm
  autocmd BufNewFile,BufRead *.inc set filetype=nasm
  autocmd BufNewFile,BufRead *.s set filetype=asm
augroup END

" Section: Vimscript file settings -------------------- {{{
augroup filetype_vim
  autocmd!
  " Close all folds
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" }}}

" Section: Snippets ----------------------------------------- {{{
augroup snippets
  autocmd!
  autocmd FileType javascript,typescript,c,cpp,rust 
        \nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
augroup END
" }}}

" Ctrl+D for Tagbar
nnoremap <C-d> :TagbarToggle<CR>
" Section: Nerd Tree config ----------------------------------- {{{
nnoremap <C-t> :NERDTreeToggle<CR>
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * silent NERDTreeMirror
" }}}
