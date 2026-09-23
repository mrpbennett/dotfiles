let mapleader = " "

set showmode

" Show line numbers
set number
set relativenumber

" Use spaces instead of tabs
set expandtab

" Default indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2

set autoindent
set smartindent

" Keep cursor away from screen edges
set scrolloff=5
set sidescrolloff=5

" Enable mouse support
set mouse=a

" Syntax highlighting
syntax enable

" Kubernetes/K3s YAML is normally 2-space indentation
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

" Useful file extensions for Kubernetes YAML
autocmd BufNewFile,BufRead *.yaml,*.yml setlocal filetype=yaml

" Warn before leaving an unsaved modified buffer
set confirm

" Don't accidentally overwrite a read-only file
set readonly
