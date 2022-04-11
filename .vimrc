set hlsearch            "高亮度反白   
set backspace=2         "可随时用退格键删除   
set autoindent          "自劢缩排   
set ruler               "可显示最后一行癿状态   
set showmode            "左下角那一行癿状态   
set nu                  "可以在每一行癿最前面显示行号啦！   

" Define tab as 4 spaces
" Taken from http://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces

syntax enable
syntax on                    " 开启文件类型侦测
filetype plugin indent on    " 启用自动补全
colorscheme zellner 

autocmd BufRead,BufNewFile *.htm,*.html,*.yml,*.yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/bundle')

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
