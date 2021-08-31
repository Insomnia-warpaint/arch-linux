# Linux 基本命令
### 1. 文件管理
- 创建目录

```bash
# mkdir 是英文 make directory [创建目录] 的缩写
mkdir directory
```
- 创建多个目录

```bash
# 一次创建多个文件用花括号括起来,多个名称用逗号分割,众所周知,这是一个数组 :smiley:
mkdir {dir1,dir2}
```

- 创建多级目录

```bash
# -p parent 英文缩写 指定文件夹父节点,若没有则创建
mkdir -p dir1/dir2/dir3
```

- 创建多个多级目录

```bash
# 解释: 在当前目录下创建 dir1/dir1.1 和 dir2/dir2.2 并在它们的最下级目录下创建dir3
mkdir -p {dir1/dir1.1,dir2/dir1.2}/dir3
```

- 移动文件/目录

```bash
# mv 是英文 move [移动] 的缩写 
# 将 当前目录的 file1 文件,移动到上一级目录中去,并且文件名叫 file2
mv file1  ../file2
```
- 一次移动多个文件/目录

```bash
# -t target-directory 英文缩写  
# 解释: 将当前目录下的 file1 file2 file3 移动到 当前目录下的 directory 目录下,文件名不变
mv file1 file2 file3 -t directory
```

- 移动所有文件

```bash
# 将 directory1 下的所有文件,移动到上一级目录的 directory2 中
mv  directory1/*  ../directory2/

```
- 复制文件

```bash
# cp 是单词 copy 的缩写
# 将当前目录下的 file1 文件复制到目录 dir1 下面
cp file1 dir1/
```
- 重命名文件/目录

```bash
# rename [重命名]
# 将 名称为 dir_name1 的文件,重命名为 dir_name2;
# 第三个参数名与第一个参数名一样,是为了确认,修改文件是否是需要修改的文件名
# 形象记忆: 我告诉 rename 命令, 叫它去把 dir_name1 去改成 dir_name2,然后告诉它,我要改的文件确实是 dir_name1 不用找我确认了, 直接修改吧！
rename dir_name1 dir_name2 dir_name1
```

### 用户管理

- 创建用户

```bash
# useradd 添加用户 或者 adduser 都行
# 添加一个用户 名字叫 insomnia  用户组和附属组 名称都是 insomnia
useradd insomnia
```

- 创建一个用户,并创建 home 目录

```bash
# -m 是英文 create-home 缩写
useradd -m insomnia
```
- 创建用户,创建用户家目录,并指定组和附属组

```bash
# wheel 组是 linux 中自带的用户组, 可以提权到 root
useradd -m -g users -G wheel insomnia
```

- 组和附属组的区别
 - linux 中 一个用户有且只有一个组,但是可以有多个附属组
 - 形象记忆：
 > 一个人出生了(创建用户),她是家庭(组)中的一员,她能力很强,在多个公司任职(附属组),并且可以随时动用这些权利为她做不同的事
 
 可能比喻的不是很好,这只是我自己的理解<br>请不要挑刺,说什么"她一出生就能工作,可太牛了" 这样的话

- 创建用户,创建家目录,并指定用户组,附属组,和 shell

```bash
# linux 下有很多种 shell 比如 默认的 bash,还有一些比较流行的 fish, zsh 等 
useradd -m -g users -G wheel -s /bin/bash insomnia
```

- 添加组

```bash
# 添加一个组, 名字叫 operation
groupadd operation 
```

- 删除组

```bash
# 删除名叫 operation 的组
groupdel operation
```

- 更改用户的固定组

```bash
# 将 insomnia 的用户组重新设置为 wheel 
# 如果执行下面命令 则用户以前所属的附属组也会被清空,并设置成 wheel 可以加 -G [附属1],[附属组2]
usermod -g wheel insomnia
```
- 添加用户到附属组

```bash
# 命令 gpasswd 中的 g 指的是 group(组)
# -a  add 的缩写
# 解释: 将 insomnia 用户, 添加到 operation 组中
gpasswd -a insomnia operation

```
- 将用户从附属组中删除

```bash 
# -d delete 的缩写
# 将用户从 operation 组中删除
gpasswd -d insomnia operation
```

- 更改用户密码

```bash
# 更改当前用户的密码
passwd
# 更改 insomnia 的密码
passwd insonia
```

## 权限管理

- 更改文件权限

```bash
# chmod 是英文 change mode 的缩写
# 解释: 赋予当前用户对 dir1 [文件/目录] 读写执行的操作权限
chmod u+rwx dir1

# 解释:赋予当前用户所在组对 dir1 [文件/目录] 读,执行的操作权限
chmod g+rx dir1

# 解释:赋予其他用户对 dir1 [文件/目录] 读,写的操作权限
chmod o+rw dir1

# 解释: 取消当前用户对 dir1 [文件/目录] 执行的操作权限
chmod u-x dir1

# 解释: 取消当前用户所在组对 dir1 [文件/目录] 读,写,执行的操作权限
chmod g-rwx dir1

# 解释 赋予用户,用户所属组,其他用户对  dir1[文件/目录] 及其以下的[文件目录] 的读,写,执行操作权限
# -R 是英文 recursion[递归] 的缩写 
chmod -R +rwx dir1 
```

```txt 
科普:
linux 系统中,权限分为三种:
1.读(read)
2.写(write)
3.执行(execute)
这三种权限,根据用户,用户所属组,又被分为了三类:
1.当前用户(user)
2.当前用户所在组(group)
3.其他用户(other)


目录权限示例:
# 权限	  硬链接数  文件创建者     所属组   文件大小       时间       文件夹名
drwxr-x--x   3     insomnia    insomnia   4096    8月 31 22:03    dir1
drwxr-x--x   3     insomnia    insomnia   4096    8月 31 23:10    dir2
使用命令 ls -ll 显示出当前文件夹下的文件详情:<br>
drwxr-x--x 可以分为四部分:
d, rwx, r-x, --x <br>
1. 第一部分`d`:
	- d(directory) 表示这是一个目录
2. 第二部分	`rwx`表示创建者对文件夹的操作权限
	- r(read) 		读
	- w(write)		写
	- x(execute) 	执行
表示当前用户可以对文件夹进行读写执行操作
3. 第三部分`r-x`
	- r(read)		读
	- -(write)		写
	- x(exec-te)	执行
表示用户所在组的成员有读和执行的权限, 写权限的位置变成了`-`表示没有写文件的权限
4. 第四部分`--x`
	- -(read) 		读
	- -(write) 		写
	- x(execute) 	执行
表示其他用户对此文件夹只有执行权限,没有读写权限,读和写的位置都变成了`-`
```

- 更改文件所有者和组

```bash
# chown 是英文 change owner[改变所有者] 的缩写
# 改变 dir1[文件/目录]的所有者为 insomnia 组为 wheel
# 语法 chown [用户]:[组] [文件/目录]名
chown insomnia:wheel dir1
```
## 服务管理

- 开启服务

```bash
# 语法:  systemctl [start|stop|enable|disable|restart] [服务名]
# systemctl 中 ctl 是 control[控制] 的缩写 
# 开启 dhcpcd 服务
systemctl enable dhcpcd
```
- 关闭服务

```bash
systemctl disable dhcpcd
```
- 启动服务

```bash
systemctl start dhcpcd
```

- 停止服务

```bash
systemctl stop dhcpcd
```

- 重新启动服务

```bash
systemctl restart iwd
```

### 切换静态ipg
 发行版: CentOS7
- 方法一:
	1. 查看ip地址

	```bash
	ifconfig
	```
	2. 查看路由表

	```bash
	route -n
	# Gateway 网关地址
	# Genmask 网络掩码
	# Flags  U 正在使用 H 目标是一个主机 G 路由指向网关
	# Iface 网卡名
	# 路由表
	Kernel IP routing table
	Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
	0.0.0.0         192.168.11.1    0.0.0.0         UG    100    0        0 ens33
	192.168.11.0    0.0.0.0         255.255.255.0   U     100    0        0 ens33

	```
	3. 更改配置文件
		- **配置文件中没有的属性自行添加**
		
	```bash
	sudo vim /etc/sysconfig/network-script/ifcfg-[网卡名]
	BOOTPROTO="static" # 将 dncp 改成 static
	IPADDR=190.168.11.222 # ip地址必须在路由表中正在使用的网卡所对应的网段内
	GATEWAY=0.0.0.0 # 网关是路由表中正在使用的网卡所对应的网关
	GENMASK=255.255.255.0 #网络阉码是路由表中正在使用的网卡所对应的网络阉码
	```
	4. 重启网络服务

	```bash
	systemctl reatart network
	```
	5. ping 静态ip地址
		若能`ping`通,说明设置成功

	```bash
	ping 190.168.11.222
	```
- 方法二:

	1. 使用`ip`命令添加地址	
	<br> 这种方法不是持久的,重启后就失效了
	```bash
	# 例如 ip address add 192.168.11.222/24 dev ens33
	ip address add [ip地址]/[网络号位数] dev [网卡名]
	``` 
	2. 开机自动分配ip地址

	```bash
	sudo vim /etc/rc.local
	# 添加下面命令
	/usr/sbin/ip address add 192.168.11.222/24 dev ens33
	```

	3. 查看 ip

	```bash
	ip address show
	```
