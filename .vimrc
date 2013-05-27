set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set smarttab
set number
set ruler
set title
set mouse=a
set laststatus=2
set guioptions-=T
set guioptions-=r
set guioptions-=L

filetype plugin indent on
syntax on
colorscheme eclipse

" concurrent make
if filereadable('/proc/cpuinfo')
    let &makeprg = 'make -j'.(system('grep -c ^processor /proc/cpuinfo')+0)
endif

" SLIMV
let g:slimv_swank_cmd = '! xfce4-terminal -x sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &'

" Pathogen
call pathogen#infect()