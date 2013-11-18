" 
" ~/.vimrc
"
" Author: Drew Thoreson
"

" automatically determine file type
filetype plugin indent on

" enable syntax highlighting
syntax on

" preserve indentation when no filetype-specific indenting is enabled
set autoindent

" insert whitespace according to shiftwidth
set smarttab

" number lines
set number

" display the cursor position
set ruler

" set the window title
set title

" allow use of the mouse
set mouse=a

" always display the status line
set laststatus=2

" use markers for folding
set foldmethod=marker

" colour column 80 for controlling line length
set colorcolumn=80

" use a minimal interface in GUI mode
set guioptions-=T
set guioptions-=r
set guioptions-=L

" custom colour scheme
colorscheme greenery

" concurrent make
if filereadable('/proc/cpuinfo')
    let &makeprg = 'make -j'.(system('grep -c ^processor /proc/cpuinfo')+0)
endif

" SLIMV
let g:slimv_swank_cmd = '! urxvt -e sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &'

" Pathogen
call pathogen#infect()
