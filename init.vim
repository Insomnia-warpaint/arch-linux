lua require('plugins')
"
set clipboard+=unnamedplus
let g:vimspector_enable_mappings = 'HUMAN'
let g:mapleader = '\'
colorscheme gruvbox
let g:gruvbox_italic=1
" let g:gruvbox_termcolors=16
"
set showcmd
set virtualedit=all
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
set hlsearch
set laststatus=2 "永久显示状态栏
set noswapfile    " 不生成.swap文件
set cursorline
set autowrite
set nrformats= "把所有的数字当理解成十进制 00 or 0x
set ts=4 sw=4 expandtab
set display=truncate "如果末行被截短，显示 @@@ 而不是隐藏整行
set nrformats-=octal
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
"set guifont=fantasque\ sans\ mono\ nerd\ font\ 12
set history=200
set splitright
set splitbelow
"set guifont=droidsansmono\ nerd\ font\ 11
"set guifont=dejavu\ sans\ mono\ nerd\ font\ 12
"set list
"set listchars=tab:>-,trail:- "显示tab和space"


"if(has('mouse'))
"	set mouse=a
"endif
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

"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
inoremap jk <esc>

"noremap h ^
noremap <F2> :set number!<CR>
noremap <F3> :set hls!<CR>
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>

"j k 操作屏幕行，gj gk 操作文本行
nnoremap rs :source %<CR>
nnoremap <C-s> :w<CR>
nnoremap tt :NvimTreeToggle<CR>
nnoremap J <Nop>
nnoremap K <Nop>


" cnoremap 命令模式映射
cnoremap <C-p> <Up> 
cnoremap <C-n> <Down>


nmap <leader>1 :tabn 1 <CR>
nmap <leader>2 :tabn 2 <CR>
nmap <leader>3 :tabn 3 <CR>
nmap <leader>4 :tabn 4 <CR>
nmap <leader>5 :tabn 5 <CR>
nmap <leader>6 :tabn 6 <CR>
nmap <leader>7 :tabn 7 <CR>
nmap <leader>8 :tabn 8 <CR>
nmap <leader>9 :tabn 9 <CR>
nmap <leader>0 :tabn 0 <CR>
nmap <leader>p :tabprevious <CR>
nmap <leader>n :tabnext <CR>

autocmd BufNewFile * call AutoAppendHeader()


" 
function! AutoAppendHeader()
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
		call append(line('$'),'#include <stdlib.h>')
		call append(line('$'),'')

	elseif 'h' == tolower(suffix)
		let h_classic = '_INCLUDE_' . substitute(toupper(strcharpart(bufname(), strridx(bufname(), '/') + 1, strlen(bufname()))), '\.', '_', '') . '_'
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


function! CharIndexOf(str, ch, idx)
	let str = a:str
	let ridx = a:idx
	let idx = 0

	let strlen = strlen(str)

	for i in range(strlen)
		
	endfor
endfunction


function! Str2CharList(str)
	let str = a:str
	let nrList = str2list(str)
	let limit = len(nrList)
	let sIdx = 0	
	while sIdx < limit
		
		let nrList[sIdx] = nr2char(nrList[sIdx])
		let sIdx += 1

	endwhile
	
	return nrList

endfunction


function! StrToCharList(str)

 let nStr = a:str
 let nStrLen = len(a:str)
 let nList = ''
 let comma = ','

 for i in range(nStrLen)
	
	let nList .=  nr2char(strgetchar(nStr, i))

	if nStrLen - 1 != i 
		let nList .= comma
	endif

 endfor
 
 let nList = split(nList, comma)
 
 return nList

endfunction



function! FlipStr(str)
	
	let str = a:str
	let limit = strlen(str) - 1
	let sIdx = 0
	let eIdx = limit
	let aList = str2list(str)
	
	while sIdx <= limit / 2
		let tmpItm = aList[sIdx]
		let aList[sIdx] = aList[eIdx]
		let aList[eIdx] = tmpItm
		let sIdx += 1
		let eIdx -= 1
	endwhile
	
	let str = list2str(aList)
	return aList

endfunction	

:function! Count_words() range
: let lnum = a:firstline
: let n = 0
: while lnum <= a:lastline
:	let n = n + len(split(getline(lnum)))
:	let n = n + 1
: endwhile
: echo "found" . n . "words"
:endfunction



:function! Min(x, y)
: try
:	 let x = a:x
:	 let y = a:y
:	 if x < y
:		return x
: 	 else
:		return y
: 	 endif
: catch '.*'
:	 return 'Please type a number'
: endtry
:endfunction




function! ThrowException()
	throw 'This is my first exception'
endfunction


function! TryCatchMyExp()
	try 
		call ThrowException()
	catch '^This is my first exception'
		return 'capture the exception.'
	endtry
endfunction
