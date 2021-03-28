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
  " clang-format
  Plug 'rhysd/vim-clang-format'
  " Like vscode intellisense
  Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()

" Color Theme
set termguicolors
set background=dark
let g:onedark_terminal_italics=1
colorscheme onedark

let g:clang_format#style_options = { "IndentWidth": 4 }
" Use .clang-format file for style options
let g:clang_format#detect_style_file = 1
let g:clang_library_path='/Library/CommandLineTools/usr/lib'
" Show line numbers
set number
set ruler

" Use 4 spaces for indentation in c-family languages.
autocmd FileType c,cpp,objc setl et ts=4 sw=4 ci sts=4 
autocmd FileType c,cpp,objc ClangFormatAutoEnable
" Use an indentation of 2 spaces in xml-like files.
autocmd FileType html,xhtml,css,xml,xslt setl et ts=2 sw=2 sts=2
" In Makefiles, don't use tabs (because they are necessary).
autocmd FileType make setl noet sw=8 sts=0
" Use tabs in assembly and set the default assembler syntax to NASM.
let g:asmsyntax = "nasm"
autocmd FileType asm setl noet sw=8 sts=0 syntax=nasm
autocmd BufNewFile,BufRead *.asm set ft=nasm
autocmd BufNewFile,BufRead *.s set ft=asm

nn <C-t> :NERDTreeToggle<CR>
" Use opt+j and opt+k to move indiviudal lines up and down
" macOS has some weird keyboard stuff so...
nn ∆ :m .+1<CR>==
nn ˚ :m .-2<CR>==
ino ∆ <Esc>:m .+1<CR>==gi
ino ˚ <Esc>:m .-2<CR>==gi
vn ∆ :m '>+1<CR>gv=gv
vn ˚ :m '<-2<CR>gv=gv
