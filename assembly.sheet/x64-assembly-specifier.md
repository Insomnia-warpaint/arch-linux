# x64 寄存器
- x64 汇编使用`16`个`64位`寄存器.
 - `x` 后缀表示`extended` 表示该寄存器是之前寄存器的拓展版本
 - `a` - `accumulator`
 - `b` - `base addressing`
 - `c` - `counter`
 - `d` - `data`
 - `sp`- `stack pointer`
 - `bp`- `base pointer`
 - `si`- `source index`
 - `di`- `destination index`

| 寄存器名称|含义|
| :--: | :--: | :--: |
|%rax|累加器|
|%rbx|寻址|
|%rcx|[计数/迭代]器|
|%rdx|数据寄存器|
|%rsp|栈指针|
|%rbp|[基/帧]指针|
|%rsi|源索引|
|%rdi|目标索引|

- 还有一些低字节的寄存器可以作为`32位`,`16位`,`8位`寄存器使用 对于8位寄存器`L`后缀表示低`H`后缀表示高
