"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Description:
"   My Vim Configuration
" Author:
"   Phoenix
"

" So 'vim-polyglot' can work
set nocompatible

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    " I use C/C++, rust, and JS/TS
    !./install.py --clangd-completer --rust-completer --ts-completer
  endif
endfunction

" I use vim-plug: https://github.com/junegunn/vim-plug
call plug#begin()
  " Enhanced syntax highligting
  Plug 'sheerun/vim-polyglot'
  " Atom OneDark theme for vim
  Plug 'joshdick/onedark.vim'
  " File browser
  Plug 'preservim/nerdtree'
  " Like vscode intellisense
  Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') } 
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
call plug#end()

" Color Theme
if $COLORTERM == 'truecolor'
  set termguicolors
endif
set background=dark
let g:onedark_terminal_italics=1
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste'],
      \ [ 'readonly', 'filename', 'modified' ]
    \ ]
  \ },
\ }

" Show line numbers
set number

set laststatus=2
set noshowmode
colorscheme onedark

augroup YCMConfig
  autocmd!
  " Use markdown in rust documentation
  autocmd FileType rust let b:ycm_hover = {
        \ 'command': 'GetDoc',
        \ 'syntax': 'markdown'
        \ }
augroup END

" Use 4 spaces for indentation in c-family languages.
autocmd FileType c,cpp,objc setl et ts=4 sw=4 ci sts=4 
" Use an indentation of 2 spaces in xml-like files.
autocmd FileType html,xhtml,css,xml,xslt setl et ts=2 sw=2 sts=2
" In Makefiles, don't use tabs (because they are necessary).
autocmd FileType make setl noexpandtab ts=4 shiftwidth=4 softtabstop=4
" Use tabs in assembly and set the default assembler syntax to NASM.
let g:asmsyntax = "nasm"
autocmd FileType asm setl noet sw=8 sts=0 syntax=nasm
autocmd BufNewFile,BufRead *.asm set ft=nasm
autocmd BufNewFile,BufRead *.s set ft=asm

nn <C-t> :NERDTreeToggle<CR>
" Some VSCode Keybindings
nn <F12> :YcmCompleter GoToDefinition<CR>
nn <leader>F :YcmCompleter Format<CR> 
nn <leader>. :YcmCompleter FixIt<CR>
nn <C-s> :w<CR>
ino <C-s> <Esc> :w<CR>i
nn <leader><C-s> :wa<CR>

" Use the arrow keys to move indiviudal lines up and down
nn <Up> :m .-2<CR>==
nn <Down> :m .+1<CR>==
