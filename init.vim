"

if empty(glob('~/.config/nvim/autoload/plug.vim'))

	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

"

call plug#begin('~/.config/nvim/plugged')

"Markdown 插件    
Plug 'iamcco/markdown-preview.nvim',{'do': { -> mkdp#util#install() },'for': ['markdown', 'vim-plug']}

" 文件管理插件 可以预览目录    
Plug 'scrooloose/nerdtree'        


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" coc 语法提示 
Plug 'neoclide/coc.nvim',{'branch': 'release'}

call plug#end() 

"

let g:mapleader = ","

"

set number "显示行号
set nocompatible "去掉有关vi一致性模式，避免以前版本的bug和局限
set autoindent "vim 使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进)
set ruler "在编辑过程中，在右下角显示光标位置的状态行
set incsearch "设置自动匹配单词的位置
set backspace=2
set ignorecase "查找时忽略大小写
set nohlsearch "查找匹配到的所有单词不高亮显示，只高亮光标所在单词。
set laststatus=2 "永久显示状态栏
set noswapfile    " 不生成.swap文件
set cursorline
set ts=4
set sw=4

"

filetype on "检测文件的类型
syntax enable "语法高亮 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "记住vim 退出时光标的位置

"

" :map 递归映射
" :noremap 非递归映射
" :nnoremap 正常模式映射
" :vnoremap 可视模式和选择模式映射
" :xnoremap 可视模式映射
" :snoremap 选择模式映
" :onoremap 操作待决模式映射
" :noremap! 插入和命令模式映射
" :inoremap 插入模式映射
" :cnoremap 命令模式映射

"

inoremap <Up> <C-p>
inoremap <Down> <C-n>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap '<CR> <C-y>
inoremap jk <Esc>
"

noremap H 0
noremap <F3> :set number!<CR> 
noremap L $

"

nnoremap rs :source %<CR> 
nnoremap <C-s> :w<CR>
nnoremap tt :NERDTreeToggle<CR>
nnoremap mg J
nnoremap <F5> :!javac % && java %:r <CR>

"
