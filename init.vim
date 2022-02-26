"
if empty(glob('~/.config/nvim/autoload/plug.vim'))&&has('nvim')

	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

elseif empty(glob('~/.vim/autoload/plug.vim'))

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
" 语法提示插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asyncrun.vim'
Plug 'jayli/vim-easycomplete'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" icon
Plug 'ryanoasis/vim-devicons'
" debug
Plug 'puremourning/vimspector'
"Plug 'rhysd/open-pdf.vim'
" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafalbromirski/vim-airlineish'
Plug 'edkolev/promptline.vim'
Plug 'tpope/vim-fugitive'
"Plug 'webastien/vim-ctags'
" 主题插件
Plug 'morhetz/gruvbox'
"Plug 'jiangmiao/auto-pairs' " 符号补全
Plug 'cdelledonne/vim-cmake'

call plug#end()

"
set clipboard+=unnamedplus
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_base_dir=expand('$HOME/.vim/vimspector-config')
let g:mapleader = ","
"colorscheme gruvbox
let g:gruvbox_italic=1
" let g:gruvbox_termcolors=16
"
set showcmd
"set virtualedit=all
set linebreak
set guioptions+=b " 底部显示滑块
set fileformats=unix,dos,mac
set textwidth=80
set helplang=cn
set ambiwidth=double
set showmatch
set number
set background=dark
set autoindent "vim 使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进)
set ruler "在编辑过程中，在右下角显示光标位置的状态行
set incsearch "设置自动匹配单词的位置
set backspace=2
set ignorecase "查找时忽略大小写
set nohlsearch "查找匹配到的所有单词不高亮显示，只高亮光标所在单词。
set laststatus=2 "永久显示状态栏
set noswapfile    " 不生成.swap文件
set cursorline
set autowrite
set nrformats= "把所有的数字当理解成十进制 00 or 0x
"set list
"set listchars=tab:>-,trail:- "显示tab和space"
set ts=4
set sw=4
set display=truncate "如果末行被截短，显示 @@@ 而不是隐藏整行
set nrformats-=octal
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
"set guifont=droidsansmono\ nerd\ font\ 11
"set guifont=dejavu\ sans\ mono\ nerd\ font\ 12
set guifont=fantasque\ sans\ mono\ nerd\ font\ 12


if(has('mouse'))
	set mouse=a
endif
"

filetype on "检测文件的类型
syntax enable "语法高亮
au bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "记住vim 退出时光标的位置

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
"noremap

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap jk <esc>
"inoremap \" \"\"<esc>i
"inoremap < <><esc>i
"inoremap ( ()<esc>i
"inoremap [ []<esc>i
"inoremap <A-k> <c-p>
"inoremap <A-j> <c-n>

"
"

"noremap h ^
noremap <F3> :set number!<CR>
"noremap L $
"noremap <UP> gk
"noremap <DOWN> gj
"noremap k gk
"noremap j gj
nnoremap mk :MarkdownPreview<CR>
" JSON Format
nnoremap <Leader>jf :%!jq .<CR>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"

nnoremap rs :source %<CR>
nnoremap <C-s> :w<CR>
nnoremap tt :NERDTreeToggle<CR>
let NERDTreeWinPos=1
"nnoremap J <C-f>
"nnoremap K <C-b>
nnoremap J <Nop>
nnoremap K <Nop>
"nnoremap mg J

"
let g:mapleader = '\'
"let g:promptline_powerline_symbols = 1
"let g:Powerline_symbols= 'unicode'


"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#branch#enabled = 1
let g:airline_theme = 'airlineish'
"let g:airline_theme = 'gruvbox'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ' '
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty= '⚡'
let g:airline_section_b = '%{fugitive#head()}'
let g:airline_section_x = '%{&filetype}'
let g:airline_section_d = ""
let g:airline_section_z  = airline#section#create(['%p%% ',"-",' %l ',"-",' %c '])
let g:airline_section_error  = ''
let g:airline_section_warning = ''

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


autocmd BufNewFile * call AutoAppendHeader()


" 
func! AutoAppendHeader()
	let suffix = strcharpart(bufname(), strridx(bufname(),'.') + 1, strlen(bufname()))
	if 'c' == tolower(suffix)
		call append(line('$'),'/*')
		call append(line('$'),' *')
		call append(line('$'),' * Created on: ' . $USER)
		call append(line('$'),' * Date: ' . strftime("%Y-%m-%d %H:%M:%S"))
		call append(line('$'),' *')
		call append(line('$'),' */')
		call append(line('$'),'')
		call append(line('$'),'')
		call append(line('$'),'')
		call append(line('$'),'#include <stdio.h>')
		call append(line('$'),'#include <stdbool.h>')
		call append(line('$'),'')

	elseif 'h' == tolower(suffix)
		let h_classic = '_INCLUDE_' . substitute(toupper(strcharpart(bufname(), strridx(bufname(), '/') + 1, strlen(bufname()))), '\.', '_', '_')
		call append(line('$'),'/*')
		call append(line('$'),' *')
		call append(line('$'),' * Created on: ' . $USER)
		call append(line('$'),' * Date: ' . strftime("%Y-%m-%d %H:%M:%S"))
		call append(line('$'),' *')
		call append(line('$'),' */')
		call append(line('$'),'')
		call append(line('$'),'')
		call append(line('$'),'')
		call append(line('$'),'#ifndef ' . h_classic)
		call append(line('$'),'#define ' . h_classic)
		call append(line('$'),'')
		call append(line('$'),'')
		call append(line('$'),'')
		call append(line('$'),'#endif')
	endif
	execute ':$'
endfunction

" 获取字符在字符串中的位置
function! GetCharIndexOf(str, ch, idx)
  let l:len = strlen(a:str)
  let l:idx = 0
  let l:total = 0
  let l:i = 0

  while l:i < l:len
	
  endwhile
endfunction


function! ConvertStrToArray(str)
 let i = 0
 let l:str = a:str
 let strlen = len(a:str)
 
 for i in range(strlen)
	let l:ch =  strgetchar(l:str)
	let l:arr = '{' . l:ch
 endfor



endfunction

			
