"

if empty(glob('~/.vim/autoload/plug.vim'))

	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

"

call plug#begin('~/.vim/plugged')

"Markdown 插件    
Plug 'iamcco/markdown-preview.vim',{'do': { -> mkdp#util#install() },'for': ['markdown', 'vim-plug']}

" 文件管理插件 可以预览目录    
Plug 'scrooloose/nerdtree'        
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'rakr/vim-one'
Plug 'chriskempson/base16-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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
"set t_Co=256
set ts=4
set sw=4

"

filetype on "检测文件的类型
syntax enable "语法高亮 
colorscheme base16-default-dark
let base16colorspace=256
set termguicolors
"let background=light       " for the light version
"let g:one_allow_italics = 1 " I love italic for comments
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "记住vim 退出时光标的位置

"

" :map 递归映射
" :noremap 非递归映射
" :nnoremap 正常模式映 
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
inoremap jk <Esc>
"

noremap H ^ 
noremap <F3> :set number!<CR> 
noremap L $
nnoremap mk :MarkdownPreview<CR>

"

nnoremap rs :source %<CR> 
nnoremap <C-s> :w<CR>
nnoremap tt :NERDTreeToggle<CR>
let NERDTreeWinPos=1
nnoremap J <C-f>
nnoremap K <C-b>
nnoremap mg J

"
let g:mapleader = ',' 
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#left_sep = ' ' 
let g:airline#extensions#tabline#left_alt_sep = '|' 
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 1 
let g:airline#extensions#tabline#close_symbol='X'
let g:airline_section_c = airline#section#create(['%t'])
let g:airline_section_x = airline#section#create(['%Y'])
let g:airline_section_y = ""
let g:airline_section_z  = airline#section#create(['%p%% ',"-",' %l 行',"-",' %c 列'])
let g:airline_section_error  = ""
let g:airline_section_warning = airline#section#create([strftime('%F'),"|",strftime('%R')])
"let g:airline_theme = 'one'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>p <Plug>AirlineSelectPrevTab
nmap <leader>n <Plug>AirlineSelectNextTab
