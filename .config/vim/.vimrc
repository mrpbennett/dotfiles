" remap <leader> to ,
:let mapleader = "<space>"

" auto install with vim-plug" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin()

" NERDTree
Plug 'preservim/nerdtree'

" Tabline status
Plug 'vim-airline/vim-airline'

" Themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" Shows git diff in gutter
Plug 'airblade/vim-gitgutter'

" OneDark theme
Plug 'joshdick/onedark.vim'

call plug#end()

" live reload files if it changes on disk
set autoread

" line numbers
set number

set autoindent

" sets tab length
set shiftwidth=4
set tabstop=4

" hides status
set noshowmode

" sets shell to zsh
set shell=bash

" OneDark settings
syntax on
colorscheme onedark

" additional escapes
imap jk <esc>
imap kj <esc>

" toggle between files
nmap <leader>bb <c-^><cr>

" NERDTree keymaps
nnoremap <leader>m :NERDTreeFocus<CR>
nnoremap <space>n :NERDTree<CR>
nnoremap <space>e :NERDTreeToggle<CR>
nnoremap <space>f :NERDTreeFind<CR>
