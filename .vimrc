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

map <F5> :make<CR>
map <F6> :!urxvt -hold -e make run<CR>

" custom colour scheme
colorscheme greenery

au BufRead,BufNewFile *.scss setfiletype scheme
au BufRead,BufNewFile *.sxml setfiletype scheme

" concurrent make
if filereadable('/proc/cpuinfo')
    let &makeprg = 'make -j'.(system('grep -c ^processor /proc/cpuinfo')+0)
endif

" SLIMV
"let g:slimv_swank_cmd = '! urxvt -e sbcl --load ~/.vim/slime/start-swank.lisp &'
let g:slimv_swank_cmd = '! urxvt -e sbcl --load ~/.vim/slime/start-swank.lisp &'

" Syntastic
"let g:syntastic_c_compiler_options = ' -include kernel/common.h'

" Pathogen
call pathogen#infect()

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
