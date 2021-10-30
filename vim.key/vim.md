# vim 快捷键

## 简介:
vim 是比较经典的编辑器,以命令为中心, 非常符合`linux`系统的风格,并且占用内存非常低,可以使用少量的命令去执行比较复杂的文本任务,想要熟练使用`linux`系统, vim 编辑器的基本命令是必须要掌握的.
<br>下面然我们进入 vim 命令的学习吧!

## vim 模式介绍
- 正常模式(normal)
  - 使用 vim 打开文件, 默认进入 normal 模式,在该模式下可以做移动光标, 滚动屏幕等操作
- 插入模式(insert)
  - insert 模式下, 可以对文件进行编辑
- 视觉模式(visual)
  - visual 模式下, 可以对文件中的数据进行选中,做批量插入, 删除等操作
- 命令模式(command mode)
  - 执行命令,进行全局替换,查找等操作

## 以下是笔者日常生活中比较常用的vim命令
[更多命令请下载官方PDF文档](http://vimcdoc.sourceforge.net/)

### normal mode
#### 光标的基本移动
- `h`- 光标左移 
- `j`- 光标下移
- `k`- 光标上移
- `l`- 光标右移
- `3h`- 向左移动3位
- `5j`- 向下移动5行
- `2k`- 向上移动2行
- `4l`- 向右移动4位
- `b` - 将光标移动到上一个单词的开头
- `ge`- 将光标移动到上一个单词的结尾
- `w` - 将光标移动到下一个单词的开头
- `e` - 将光标移动到下一个单词的结尾
- `%` - 跳转符号匹配处()[]{}...
- `$` - 移动到当前行的结尾处
- `0` - 移动到当前行行首
- `gg` - 跳转到文件开头
- `G` - 跳转到文件结尾
- `{` - 跳转到上一个段落开头
- `}` - 跳转到下一个段落的开头
- `Ctrl`+`b` - 屏幕向上滚动一屏
- `Ctrl`+`f` - 屏幕向下滚动一屏
- `zz` - 将屏幕调整到以光标所在行为中心
- `[[` - 跳转到上一个函数的开头`{`必须单独占一行(c程序员狂喜)
- `]]` - 跳转到下一个函数的开头`}`必须单独占一行(java程序员哭晕在策说)

#### 基本编辑命令
- `u` - 撤销
- `Ctrl`+`r` -恢复上一步撤销的操作
- `y`(yank) - 复制，中文有拉拽的意思。将内容yank到缓冲区
- `p`(paste) - 粘贴
- `cc`(cut) - 剪切当前行
- `dd`(delete) - 删除整行
- `3dd` - 从当前行开始,删除`3`行
- `3y` - 从当前行开始,复制`3`行
- `~` - 将字母进行大小写转换
- `g~~` - 将整行的单词进行大小写转换

### insert mode
#### 进入插入模式
- `i`(insert) -  在光标前进行插入
- `a`(append) - 在光标后进行插入
- `o`(open) - 在当前行下面另起一行进行插入
- `O`(open) - 在当前行上面另起一行进行插入
- `Esc` - 退出插入模式

### visual model
#### 可视模式基本操作
- 在 normal model 下按 `v` 进入可视模式 **(可以理解为`windows`中用鼠标将一段文本选中)**
- `d`(批量删除) - 删除选中的文本
- `y`(yank) - 复制选中的文本到缓冲区

#### 可视块模式下的批量插入
- `Ctrl`+`v` - 进入可视块模式 **(可以理解为用鼠标将一段话或者一段代码中的某一块选中,一般高级一点的编辑器都会有这样的功能)**

 1. 按`Ctrl`+`v`进入可视块模式并且选中一段话
 2. 在这段话的某一列按大写`I`,进入插入模式,然后输入一个字或者一个字母
 3. 按`Esc`切换到`normal`模式
 -  批量插入完成！
**批量替换,将(大写)`I`改成(小写)`c`**

 ### commond mode
 #### 简单的 vim 命令
 - `:set nu` - 显示行号
 - `:set nu!`- 关闭行号
 - `:%s/old/new/g` - 将文件中所有的`old`替换为`new` `g`:`gobal` `s`:`switch` 
 - `:%s/old/new/gc` - 逐个将`old`替换为`new` `g`:`gobal` `s`:`switch` `c`:`count`
 - `:20` - 移动到20行的位置
 - `/root` - 全局搜索`root`这个单词, `n` 跳转到下个搜索到的位置 `N` 跳转到上一个搜索到的位置


### string_functions
 ```vim
nr2char() 通过数值码值取得一个字符
list2str() 从数值列表取得字符字符串
char2nr() 取得字符的数值码值
str2list() 从字符串取得数值列表
str2nr() 把字符串转换为数值
str2float() 把字符串转换为浮点数
printf() 根据 % 项目格式化字符串
escape() 将字符串通过 ’\’ 转义
shellescape() 转义字符串用于外壳命令
fnameescape() 转义 Vim 命令使用的文件名
tr() 把 组字符翻译成另æ 组
strtrans() 将一个字符串变成可显示的格式
tolower() 将一个字符串转换为小写
toupper() 将一个字符串转换为大写
match() 字符串中的模式匹配处
matchend() 字符串中的模式匹配结束处
matchstr() 在一个字符串中匹配一个模式
matchstrpos() 字符串中满足匹配的模式和位置
matchlist() 类似 matchstr()，同时返回子匹配
stridx() 子串在母串中第,次出现的地方
strridx() 子串在母串中-后与次出现的地方
strlen() 以字节计的字符串长度
strchars() 以字符计的字符串长度
strwidth() 字符串的显示长度
strdisplaywidth() 字符串的显示长度，处理制表
substitute() 用一个字符串替换一个匹配的模式
submatch() 取得 ":s" 和 substitute() 匹配中指定的某个匹配
strpart() 用字节索引取得字符串的子串
strcharpart() 用字符索引获取字符串的子串
strgetchar() 用字符索引获取字符串里的字符
expand() 展录特殊的关键字
expandcmd() 像 :edit 那样扩展命令
iconv() 转换文本编码格式
byteidx() 字符串里字符的字节位置
byteidxcomp() 类似于 byteidx()，但计算组合字符
repeat() 重复字符串多次
eval() 计算字符串表达式
execute() 执行 Ex 命令并获取输出
win_execute() 类似于 execute()，但用于指定窗口
trim() 从字符串中删除字符
 ```
 ### list-functions
```vim
get() 得到项目，错误索引不报错
len() 列表的项目总数
empty() 检查列表是否为空
insert() 在列表某处插入项目
add() 在列表后附加项目
extend() 在列表后附加另一个列表
remove() 删除列表里Ì 或多个项目
copy() 建立列表的浅备份
deepcopy() 建立列表的完整备份
filter() 删除列表的选定项目
map() 改变每个列表项目
sort() 给列表排序
reverse() 反转列表项目的顺序
uniq() 删除重复邻接项目的备份
split() 分割字符串成为列表
join() 合并列表项目成为字符串
range() 返回数值序列的列表
string() 列表的字符串表示形式
call() 调用函数，参数以列表形式提供
index() 列表里某值的索引
max() 列表项目的构大值
min() 列表项目的构小值
count() 计算列表里某值的出现次数
repeat() 重复列表多次
```
### dict-funcions
```vim
get() 得到项目，错误的键不报错
len() 字典项目的总数
has_key() 检查某键是否出现在字典里
empty() 检查字典是否为空
remove() 删除字典的项目
extend() 从一个字典增加项目到另一个字典
filter() 删除字典的选定项目
map() 改变每个字典项目
keys() 得到字典的键列表
values() 得到字典的值列表
items() 得到字典的键-值组对的列表
copy() 建立字典的浅备份
deepcopy() 建立字典的完整备份
string() 字典的字符串表示形式
max() 字典项目的构大值
min() 字典项目的构小值
count() 计算字典里某值的出现次数
```
### float-functions
```vim
float2nr() 把浮点数转换为数值
abs() 绝对值 (也适用于数值)
round() 四舍五入
ceil() 向上取整
floor() 向下取整
trunc() 删除小数点后的值
fmod() 除法的余数
exp() 指数
log() 自然对数 (以 e 为底的对数)
log10() 以 10 为底的对数
pow() x 的 y 次方
sqrt() 平方根
sin() 正弦
cos() 余弦
tan() 正切
asin() 反正弦
acos() 反余弦
atan() 反正切
atan2() 反正切
sinh() 双曲正弦
cosh() 双曲余弦
tanh() 双曲正切
isnan() 检查非数
```
### bitwise-function
```vim
and() 按位与
invert() 按位取反
or() 按位或
xor() 按位异或
sha256() SHA-256 哈希
```

### var-functions
```vim
type() 变量的类型
islocked() 检查变量是否加锁
funcref() 返回指向函数的函数引用
function() 得到函数名对应的函数引用
getbufvar() 取得指定缓冲区中的变量值
setbufvar() 设定指定缓冲区中的变量值
getwinvar() 取得指定窗口的变量值
gettabvar() 取得指定标签页的变量值
gettabwinvar() 取得指定窗口和标签页的变量值
setwinvar() 设定指定窗口的变量值
settabvar() 设定指定标签页的变量值
settabwinvar() 设定指定窗口和标签页的变量值
garbagecollect() 可能情况下释放内存
```

### cursor-functions&mark-functions
```vim
col() 光标或位置标记所在的列
virtcol() 光标或位置标记所在的屏幕列
line() 光标或位置标记所在行
wincol() 光标所在窗口列
winline() 光标所在窗口行
cursor() 置光标于 行／列 处
screencol() 得到光标的屏幕列
screenrow() 得到光标的屏幕行
screenpos() 文本字符的屏幕行与列
getcurpos() 得到光标位置
getpos() 得到光标、位置标记等的位置
setpos() 设置光标、位置标记等的位置
byte2line() 取得某字节位置所在行号
line2byte() 取得某行之前的字节数
diff_filler() 得到丰行之上的填充行数目
screenattr() 得到屏幕行的属性
screenchar() 得到屏幕行的字符代码
screenchars() 得到屏幕行的多个字符代码
screenstring() 得到屏幕行的字符字符串
```

### text-functions
```vim
getline() 从缓冲区中取他行
setline() 替换缓冲区中的 行
append() 附加行或行的列表到缓冲区
indent() 某行的缩进
cindent() 根据 C 缩进法则的某行的缩进
lispindent() 根据 Lisp 缩进法则的某行的缩进
nextnonblank() 查找下一个非空白行
prevnonblank() 查找前一个非空白行
search() 查找模式的匹配
searchpos() 寻找模式的匹配
searchpair() 查找 start/skip/end 配对的另一端
searchpairpos() 查找 start/skip/end 配对的另一端
searchdecl() 查找名字的声明
getcharsearch() 返回字符搜索信息
setcharsearch() 设置字符搜索信息
getbufline() 取得指定缓冲区的行列表
setbufline() 替换指定缓冲区的 行
appendbufline() 给指定缓冲区附加行列表
deletebufline() 从指定缓冲区中删除多行
```

### system-functions&file-functions
```vim
glob() 展录通配符
globpath() 在几个路径中展录通配符
glob2regpat() 转换 glob 模式到搜索模式
findfile() 在目录列表里查找文件
finddir() 在目录列表里查找目录
resolve() 找到一个快捷方式所指
fnamemodify() 改变文件名
pathshorten() 缩短路径里的目录名
simplify() 简化路径，不改变其含义
executable() 检查一个可执行程序是否存在
exepath() 可执行程序的完整路径
filereadable() 检查一个文件可读与否
filewritable() 检查一个文件可写与否
getfperm() 得到文件权限
setfperm() 设置文件权限
getftype() 得到文件类型
isdirectory() 检查一个目录是否存在
getfsize() 取得文件大小
getcwd() 取得当前工作路径
haslocaldir() 检查当前窗口是否使用过 :lcd 或 :tcd
tempname() 取得一个临时文件的名称
mkdir() 建立新目录
chdir() 改变当前目录
delete() 删除文件
rename() 重命名文件
system() 得到字符串形式的外壳命令结果
systemlist() 得到列表形式的外壳命令结果
environ() 得到所有环境变量
getenv() 得到一个环境变量
setenv() 设置一个环境变量
hostname() 系统的名称
readfile() 读入文件到一个行列表
readdir() 从目录得到文件名的列表
writefile() 把一个行列表或 blob 写到文件里
```
### date-functions&time-functions
```vim
getftime() 得到文件的构近修改时间
localtime() 得到以秒计的当前时间
strftime() 把时间转换为字符串
strptime() 把日期/时间字符串转换为时间
reltime() 得到准确的当前或者已经经过的时间
reltimestr() 把 reltime() 的结果转换为字符串
reltimefloat() 把 reltime() 的结果转换为浮点数
```
### buffer-functions&window-functions&arg-functions
```vim
argc() 参数列表项数
argidx() 参数列表中的当前位置
arglistid() 得到参数列表的编号
argv() 从参数列表中取得 项
bufadd() 给缓冲区列表增加文件
bufexists() 检查缓冲区是否存在
buflisted() 检查缓冲区是否存在并在列表内
bufload() 确保缓冲区已加载
bufloaded() 检查缓冲区是否存在并已加载
bufname() 取得某缓冲区名
bufnr() 取得某缓冲区号
tabpagebuflist() 得到标签页里的缓冲区列表
tabpagenr() 得到标签页号
tabpagewinnr() 类似于特定标签页里的 winnr()
winnr() 取得当前窗口的窗口号
bufwinid() 取得某缓冲区的窗口 ID
bufwinnr() 取得某缓冲区的窗口号
winbufnr() 取得某窗口的缓冲区号
listener_add() 新增回调来监听改动
listener_flush() 调用监听器回调
listener_remove() 删除监听器回调
win_findbuf() 寻找包括某缓冲区的窗口
win_getid() 取得窗口的窗口 ID
win_gotoid() 转到指定 ID 的窗口
win_id2tabwin() 给出窗口 ID 获取标签页号和窗口号
win_id2win() 把窗口 ID 转换为窗口号
getbufinfo() 获取缓冲区信息的列表
gettabinfo() 获取标签页信息的列表
getwininfo() 获取窗口信息的列表
getchangelist() 获取改变列表项目的列表
getjumplist() 获取跳转列表项目的列表
swapinfo() 关于交换文件的信息
swapname() 取得缓冲区的交换文件路径
```

### command-line-functions
```vim
getcmdline() 得到当前命令行
getcmdpos() 得到命令行里的光标位置
setcmdpos() 设置命令行里的光标位置
getcmdtype() 得到当前命令行的类型
getcmdwintype() 返回当前命令行窗口类型
getcompletion() 命令行补全匹配的列表
```

### interactive-functions
```vim
browse() 显示文件查找器
browsedir() 显示目录查找器
confirm() 让用户作出选择
getchar() 从用户那里取得一个字符输入
getcharmod() 取得近键入字符的修饰符
getmousepos() 取得近已知的鼠标位置
feedkeys() 把字符放到预输入队列中
input() 从用户那里取得 行输入
inputlist() 让用户从列表里选择一个项目
inputsecret() 从用户那里取得 行输入，不回显
inputdialog() 从用户那里取得 行输入，使用对话框
inputsave() 保存和清除预输入 (typeahead)
inputrestore() 恢复预输入 (译注: 参阅 input())
```

### gui-functions
```vim
getfontname() 得到当前使用的字体名
getwinpos() Vim 窗口的位置
getwinposx() Vim 窗口的 X 位置
getwinposy() Vim 窗口的 Y 位置
balloon_show() 设置气泡的内容
balloon_split() 分割消息用于气泡的显示
balloon_gettext() 取得气泡中的文本
```

### server-functions
```vim
serverlist() 返回服务器列表
remote_startserver() 启动服务器
remote_send() 向 Vim 服务器发送字符命令
remote_expr() 在 Vim 服务器内对一个表达式求值
server2client() 向一个服务器客户发送应答
remote_peek() 检查一个服务器是否已经应答
remote_read() 从一个服务器读取应答
foreground() 将一个 Vim 窗口移至前台
remote_foreground() 将一个 Vim 服务器窗口移至前台
```

### window-size-functions
```vim
winheight() 取得某窗口的高度
winwidth() 取得某窗口的宽度
win_screenpos() 取得某窗口的屏幕位置
winlayout() 取得标签页中窗口的布局
winrestcmd() 恢复窗口大小的返回命令
winsaveview() 得到当前窗口的视图
winrestview() 恢复保存的当前窗口的视图
```

### popup-window-functions
```vim
popup_create() 在屏幕中央创建弹出
popup_atcursor() 在光标位置正上方创建弹出，光标移û时关闭
popup_beval() 在 v:beval_ 变量指定的位置，光标移û时关闭
popup_notification() 用三秒钟显示通知
popup_dialog() 创建带填充和边框中间对齐的弹出
popup_menu() 提示从列表中选择一个项目
popup_hide() 临时隐藏弹出
popup_show() 显示之前隐藏的弹出
popup_move() 改变弹出的位置和大小
popup_setoptions() 覆盖弹出的选项
popup_settext() 替换弹出缓冲区的内容
popup_close() 关闭一个弹出
popup_clear() 关闭所有弹出
popup_filter_menu() 从一列项目中选择
popup_filter_yesno() 等待直到按了 ’y’ 或 ’n’ 为止
popup_getoptions() 取得弹出的当前选项
popup_getpos() 取得弹出的实际位置和大小
```

### timer-functions
```vim
timer_start() 建立定时器
timer_pause() 暂停或继续定时器
timer_stop() 停止定时器
timer_stopall() 停止所有定时器
timer_info() 获取定时器信息
```

### promptbuffer-functions
```vim
prompt_setcallback() 设置缓冲区的提示回调
prompt_setinterrupt() 设置缓冲区的中断回调
prompt_setprompt() 设置缓冲区的提示文本
```
