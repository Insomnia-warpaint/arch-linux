"---------------------------------------------------------------------------------------

if empty(glob('~/.config/nvim/autoload/plug.vim'))

	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

"---------------------------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

"Markdown 插件    
Plug 'iamcco/markdown-preview.nvim',{'do': { -> mkdp#util#install() },'for': ['markdown', 'vim-plug']}

" 文件管理插件 可以预览目录    
Plug 'scrooloose/nerdtree'        

"自动引号&括号补全插件 
Plug 'jiangmiao/auto-pairs'   

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"嵌套括号高亮
Plug 'luochen1990/rainbow'

" 集成Tmux 
Plug 'christoomey/vim-tmux-navigator'

" 可视化的缩进
Plug 'Yggdroot/indentLine'
" coc 
Plug 'neoclide/coc.nvim',{'branch': 'release'}

call plug#end() 

"---------------------------------------------------------------------------------------
let mapleader = "\<space>"
let g:mapleader = "\<space>"
set number "显示行号
set nocompatible "去掉有关vi一致性模式，避免以前版本的bug和局限
filetype on "检测文件的类型
set autoindent "vim 使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进)
set ruler "在编辑过程中，在右下角显示光标位置的状态行
set incsearch "设置自动匹配单词的位置
set backspace=2
syntax on "语法高亮 
set ignorecase "查找时忽略大小写
set nohlsearch "查找匹配到的所有单词不高亮显示，只高亮光标所在单词。
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "记住vim 退出时光标的位置
set laststatus=2 "永久显示状态栏
set noswapfile    " 不生成.swap文件
"---------------------------------------------------------------------------------------
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
nnoremap rs :source %<CR> 
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
noremap <C-Left> <C-w><5
noremap <C-Right> <C-w>>5
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
nnoremap ; : 
inoremap <Tab> <C-n>
noremap <F3> :set number!<CR> 
nnoremap <C-s> :w<CR>
noremap L $
noremap H 0
inoremap jk <Esc>
nnoremap tt :NERDTreeToggle<CR>
nnoremap mk :MarkdownPreview<CR>
nnoremap J <C-e>
nnoremap K <C-y>
nnoremap mg J

"----------------------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_error = ""
let g:airline_section_warning = ""
let g:airline_section_x = airline#section#create(['第 %l 行 %c 列'])
let g:airline_section_y = airline#section#create(['%{strftime("%H:%M")}']) 
let g:airline_section_z = airline#section#create (['%{strftime("%Y年%m月%d日")}'])

"-----------------------------------------------------------------------------------------
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进

"------------------------------------------------------------------------------------------
