set hlsearch            "高亮度反白   
set backspace=2         "可随时用退格键删除   
set autoindent          "自劢缩排   
set ruler               "可显示最后一行癿状态   
set showmode            "左下角那一行癿状态   
set nu                  "可以在每一行癿最前面显示行号啦！   
syntax on
colorscheme zellner 

" Define tab as 4 spaces
" Taken from http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

autocmd BufRead,BufNewFile *.htm,*.html,*.yml,*.yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

call plug#begin()
Plug 'vim-scripts/bash-support.vim'

call plug#end()
