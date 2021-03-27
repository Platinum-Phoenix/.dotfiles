"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Description:
"   My Vim Configuration
" Author:
"   Phoenix
"

" So 'vim-polyglot' can work
set nocompatible

" I use vim-plug: https://github.com/junegunn/vim-plug
call plug#begin()

" Enhanced syntax highligting
Plug 'sheerun/vim-polyglot'
" Atom OneDark theme for vim
Plug 'joshdick/onedark.vim'

call plug#end()

" Color Theme
set background=dark
" let g:onedark_terminal_italics=1
colorscheme onedark

" Show line numbers
set number

" Use 4 spaces for indentation in c-famliy languages.
autocmd FileType c,cpp,objc setl et ts=4 sw=4 ci sts=4 
" Use an indentation of 2 spaces in xml-like files.
autocmd FileType html,xhtml,css,xml,xslt setl et ts=2 sw=2 sts=2
" In Makefiles, don't use tabs (because they are necessary).
autocmd FileType make setl noet sw=8 sts=0
" Use tabs in assembly and set the default assembler syntax to NASM.
let g:asmsyntax = "nasm"
autocmd FileType asm setl noet sw=8 sts=0 syntax=nasm

" Use Ctrl+K to format with clang-format.
map <C-K> :py3f ~/.dotfiles/clang-format.py<cr>
imap <C-K> <c-o>:py3f ~/.dotfiles/clang-format.py<cr>
" Format with clang-format on save
function! FormatOnSave()
  let l:formatdiff = 1
  py3f ~/.dotfiles/clang-format.py
endfunction
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.m,*.mm call FormatOnSave()

" Use opt+j and opt+k to move indiviudal lines up and down
" macOS has some weird keyboard stuff so...
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
