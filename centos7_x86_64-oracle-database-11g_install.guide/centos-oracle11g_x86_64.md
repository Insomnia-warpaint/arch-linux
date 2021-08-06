# Centos7 Oracle 11g x86_64 安装使用手册

#### 系统&文档&安装包
- [Centos7.9.2009x86_64阿里云下载地址](http://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/)
- [oracle11g-linux_x86_64官方文档](https://docs.oracle.com/cd/E11882_01/install.112/e24326/toc.htm#CEGIHDBF)
- [oracle11g-linux_x86_64某盘链接
提取码:t883](https://pan.baidu.com/s/1rNo8Qkx6xBUed-zLB57Uzw)


### 1. 先决条件
- Centos7 操作系统
- oracle11g-linux_x86_64官方文档
- oracle11g-x86_64数据库安装包


### 2.搭建环境

- 1.更新 Centos7 镜像源地址

```bash
su root
#输入密码 切换到 root 执行
cd /etc/yum.repos.d
mkdir bak
mv *.repo bak/
wget http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache
```

- 安装 openjdk 

```bash
yum install java-1.8.0-openjdk.x86_64
```

- **`必须全部安装`** 安装 oracle11g 必要的依赖 若安装中提示包没有找到, 则 `ctrl+c` 后 再次执行即可 

```bash
yum -y install binutils* compat-libcap1* compat-libstdc++* gcc* gcc-c++* glibc* glibc-devel* ksh* libaio* libaio-devel* libgcc* libstdc++* libstdc++-devel* libXi* libXtst* make* sysstat* elfutils* unixODBC*
```

- 创建 `oracle` 用户 `oinstall` 用户组, `oper` 用户组 和 `dba` 用户组

```bash
groupadd oinstall
groupadd dba
groupadd oper
useradd -m -g oinstall -G oper,dba -s /bin/bash oracle
#查看 oracle 用户信息
id oracle
# 查看 oracle 用户是否有 sudoers 权限
visudo
# 在文件中搜索 oracle 
/oracle
# 若没有配置, 则将 root 的配置复制一行 然后把 root 改为 oracle
oracle  ALL=(ALL)       ALL
#设置 oracle 密码 我这里设置为 final
passwd oracle
# 设置密码
final
# 确认密码
final
# 等完成内核配置之后,你就可以退出登陆, 切换到 oracle 用户了
```

### 3.设置内核参数 (内核参数参照官方文档)
- 编辑 `sysctl.conf` 文件

```bash
vim /etc/sysctl.conf
```
- 将内核参数 copy 到配置文件中 保存退出

```conf
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
```
- 应用内核设置

```bash
sysctl -p
# 执行命令之后会显示你设置的参数
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576

```
---

### 4.配置用户环境变量 (下面操作均为 oracle 用户)
- 创建 oracle11g 的安装目录  **`目录没有强制要求,根目录(/)下或者自己的家目录(/home/oracle/)下都可以`** **环境变量设置正确就可以了**

```bash
#我这里已经切换到 oracle 用户了
mkdir -p ~/database/oracle11g/product/11.2.0/dbhome_1
vim ~/.bash_profile

export ORACLE_BASE=$HOME/database/oracle11g
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/lib64
export PATH

```

- 配置完成后文件内容如下(根据自己实际情况而定)

```sh
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
export ORACLE_BASE=$HOME/database/oracle11g
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$ORACLE_HOME/bin:$ORACLE_HOME/lib64
export PATH

```

- `source` 配置文件使配置生效

```bash
source ~/.bash_profile
# 查看环境变量
export
```
- 解压安装包
 - 新建文件夹放安装包
 
 ```bash
 mkdir ~/oracle11g_install
 ```
 - 移动下载到的2个安装包到 oracle 的用户目录 
 
 ```bash
 mv [安装包1.zip] ~/oracle11g_install/
 mv [安装包2.zip] ~/oracle11g_install/
 ```

```bash
cd ~/oracle11g_insall
# 若没有 unzip 则 sudo yum install unzip
unzip [安装包1.zip] # 1of2
unzip [安装包2.zip] # 2of2
```

- 安装 oralce11g

```bash
cd ~/oracle11g_install/database
./runInstaller
```

#### 接下来跟着引导程序走就可以完成安装了!

---

### 6.安装过程中遇到的问题
1. 设置完密码之后安装程序卡住了, 安装窗口变成一条竖线
 - 安装程序弹窗很小是 GNOME 桌面的原因,换一个桌面系统就可以了,亲测 KDE 没有问题.
- 安装 `KDE plasma workspaces`  

```bash
# 没有切换到 root 用户 执行命令前面需要加 sudo
yum groupinstall "KDE Plasma Workspaces"
```
##### 安装完成后

1.  `logout`(桌面右上角点击登出) 
2.  选择 oracle 用户 然后点击小齿轮
3.  选择 `kde plasma workspaces`
4.  输入密码
5.  打开 `konsole`  终端 (对着桌面右键,选择 konsole )

```bash
cd ~/oracle11g_install/database
./runInstaller
```

### 7.连接 oracle 数据库
- 开启1521端口

```bash
firewall-cmd --zone=public --add-port=1521/tcp --permanent
# 重新加载
firewall-cmd --reload
# 查看开放的端口
firewall-cmd --list-ports
# 开启成功后会显示
1521/tcp
```
- 启动监听

```bash
lsnrctl start
# 查看状态
lsnrctl status
# 开启成功 The command completed successfully
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 11.2.0.4.0 - Production
Start Date                03-AUG-2021 23:19:48
Uptime                    0 days 0 hr. 29 min. 41 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /home/oracle/database/oracle11g/product/11.2.0/dbhome_1/network/admin/listener.ora
Listener Log File         /home/oracle/database/oracle11g/diag/tnslsnr/localhost/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
    (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521)))
Services Summary...
Service "orcl" has 1 instance(s).
Instance "orcl", status READY, has 1 handler(s) for this service...
Service "orclXDB" has 1 instance(s).
Instance "orcl", status READY, has 1 handler(s) for this service...
The command completed successfully

# oralc 网络配置图形化界面
netmgr 
```

- 启动数据库

```bash
sqlplus sys/[passwd] as sysdba  # sys 用户以 dba 方式登陆 sqlplus 
# 登陆成功之后 启动数据库
SQL> startup
ORACLE instance started.

Total System Global Area 1586708480 bytes
Fixed Size		    2253624 bytes
Variable Size		  989859016 bytes
Database Buffers	  587202560 bytes
Redo Buffers		    7393280 bytes
Database mounted.
Database opened.

# 关闭数据库
SQL> shut
atabase closed.
Database dismounted.
ORACLE instance shut down.

```

### 8.开机自动启动 oracle 数据库
- 执行 root.sh 

```bash
cd $ORACLE_HOME
sudo sh root.sh
```
- 修改 $ORACLE_HOME 目录下 bin 文件夹下的 dbstart 文件

```bash
cd $ORACLE_HOME
vim ./bin/dbstart
# 找到 `ORACLE_HOME_LISTNER` 变量,将 `$1` 改成 `$ORACLE_HOME`
ORACLE_HOME_LISTNER=$ORACLE_HOME
```

- 修改 $ORACLE_HOME 目录下 install 文件夹下的 oratab 文件

```bash
cd $ORACLE_HOME
vim ./install/oratab
# 将 N 改为 Y
orcl:/home/oracle/database/oracle11g/product/11.2.0/dbhome_1:Y

```

- 修改 /etc/oratab 文件

```bash
sudo vim /etc/oratbl
# 将 N 改为 Y
orcl:/home/oracle/database/oracle11g/product/11.2.0/dbhome_1:Y

```

- 修改 /etc/rc.d/rc.local

```bash
# 在内核初始化的时候后 init.d 文件夹下的配置
# 在系统初始化的时候会去读取 rc.d 文件夹下的配置
sudo vim /etc/rc.d/rc.loacl

# 切换用户 开启监听
su oracle -lc /home/oracle/database/oracle11g/product/11.2.0/dbhome_1/bin/lsnrctl start
# 切换用户 启动数据库
su oracle -lc /home/oracle/database/oracle11g/product/11.2.0/dbhome_1/bin/dbstart

# 保存完之后 赋予- rc.local 可执行权限
sudo chmod +x /etc/rc.d/rc.local

```

###### 重启&连接数据库

```bash
reboot
# 查看监听是否开启
lsnrctl status
# 查看本机 ip 
ifconfig
# ip地址为 192.168.43.252  
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.43.252  netmask 255.255.255.0  broadcast 192.168.43.255
        inet6 fe80::ce93:84b9:b6d0:b94  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:84:e4:e5  txqueuelen 1000  (Ethernet)
        RX packets 170  bytes 181802 (177.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 177  bytes 17160 (16.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 233  bytes 21973 (21.4 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 233  bytes 21973 (21.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.122.1  netmask 255.255.255.0  broadcast 192.168.122.255
        ether 52:54:00:46:62:3d  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```
- PLSQL连接配置

```bash
vmware_centos_oracle =  # 配置的名称,自定义
  (DESCRIPTION =
    (ADDRESS_LIST =  # host 为 oracle 数据库ip地址, prot 为数据库端口
      (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.43.252)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = orcl) # 服务名称为安装时配置的名称
    )
  )

```

### 9.用户的创建与修改
- 登陆 `sys` 用户以 `sysdba` 的身份
- 查看用户

```sql
-- 语法
-- select [字段名,*代表所有字段] from [表名或者视图名]
SELECT * FROM USER$; 
```
- 创建用户

```sql
-- 语法
-- create user [用户名称] identified [密码]
CREATE USER GARBAGE IDENTIFIED final；
```
- 修改用户密码

```sql
-- 语法
-- alter user [用户名称] identified [密码]
ALTER USER SCOTT IDENTIFIED BY final; 
```

###  10.角色的赋予和表空间的创建

```sql
-- 语法
-- grant [权限名] to [用户名] with admin option 能够使被授予角色的用户将权限赋予其他角色 
GRANT CONNECT,RESOURCE,DBA TO SCOTT WITH ADMIN OPTION;
```

- 创建表空间

```sql
-- 语法
/*
create tablespace [表空间名]
datafile '[表空间物理文件位置(数据库所在电脑)]'
size [大小(单位MB)] autoextend on next [自动增长大小MB] maxsize unlimited
*/
-- autoextend on next 表空间不足时自动增长
-- maxsize 最大限制 
-- unlimited 无限制
CREATE TABLESPACE SCOTT_SPACE
DATAFILE '/home/oracle/database/oracle11g/oradata/orcl/scott_space.dbf'
SIZE 500M AUTOEXTEND ON NEXT 20M MAXSIZE UNLIMITED;
```

- 修改用户默认表空间

```sql
-- 语法
-- alter user [用户名] default tablespace [表空间名]
ALTER USER SCOTT DEFAULT TABLESPACE SCOTT_SPACE;
```

- 查看默认表空间

```sql
SELECT USERNAME,DEFAULT_TABLESPACE FROM SYS.DBA_USERS;
```

|USERNAME |DEFAULT_TABLESPACE |
| :----------: | :-----------: |
|SCOTT|SCOTT_SPACE|
|ORACLE_OCM|USERSO|
|...|...|


### 11.数据的导入和导出
#### `exp`&`imp`
- 使用`exp`导出用户下的所有数据

```bash
# 语法
# exp [用户名]/[密码]@[服务名] file=[导出文件路径和文件名] log=[日志文件路径和文件名] owner=[所有者] buffer=[缓冲区大小] recordlength=[最大64KB] direct=y
exp scott/final@orcl file=/home/oracle/oracle/backup/dmp/scott_bak.dmp log=/home/oracle/oracle/backup/log/scott_bak.log owner=scott buffer=20480000 recordlength=65535 direct=y
```

- 使用`imp`导入数据到用户

```bash
# 语法
# imp [用户名]/[密码]@[服务名] full=y (全部) file=[文件名] tablespaces=[表空间名]
imp garbage/final@orcl full=y  file=scott_bak.dmp tablespaces=scott_space
```

**注意: 使用`exp`导出的`.dmp`文件中,会导出表空间名称,在`imp`导入的时候必须使用导出时的表空间,不然无法导入! **

**解决方案:**
- 替换`.dmp` 文件中所指定的表空间

```bash
# 语法
# sed -i 's/TABLESPACE "DATA_OLD"/TABLESPACE "DATA_NEW"/g'  file.dmp
# 解释: 将文件 scott_bak.dmp 中,所有的 TABLESPACE "USERSO" 替换为 TABLESPACE "SCOTT_SPACE"
# s 替换
# g 全局
sed -i 's/TABLESPACE "USERSO"/TABLESPACE "SCOTT_SPACE"' scott_bak.dmp
```

--- 
#### `expdp`&`impdp`
- 使用`expdp`导出数据库

```sql
# 创建 文件夹路径
CREATE OR REPLACE DIRECTORY dmp_dir AS '/home/oracle/backup/dmp';
# 将读写文件夹的权限赋予 scott 用户
GRANT READ, WRITE ON DIRECTORY dmp_dir TO scott
# 查询文件夹路径
SELECT * FROM DBA_DIRECTORIES;
```
**若要自己指定导出文件夹,则需要执行上面的语句去指定文件夹,可以不指定 directory 参数的值**

```bash
# 导出数据
# expdp 
# expdp [用户名]/[密码]@[服务名] full=Y directory=[文件夹名] dumpfile=[导出的文件名] logfile=[日志文件名]
expdp scott/final@orcl full=Y directory=dmp_dir dumpfile=scott_bak.dmp logfile=scott_bak.log
```

- 使用`impdp`导入数据

```bash
# impdp [用户名]/[密码]@[服务名] full=Y directory=[文件夹名] dumpfile=[导入的文件名] logfile=[日志文件名]
impdp garbage/final@orcl full=Y directory=dmp_dir dumpfile=scott_bak.dmp logfile=scott_imp.log
```
**用`exp`导出的数据只能用`imp`导入, `expdp`导出的数据只能用`impdp`导入,一定要一一对应**

### 12.开启`DBA`可视化客户端

```bash
emctl start dbconsole
# 启动成功 访问网址 http://localhost:1158/em/console/aboutApplication
# 登陆成功之后可视化监控数据库性能 查看表空间等...
Oracle Enterprise Manager 11g Database Control Release 11.2.0.4.0
Copyright (c) 1996, 2013 Oracle Corporation.  All rights reserved.
http://localhost:1158/em/console/aboutApplication
Starting Oracle Enterprise Manager 11g Database Control .... started.
------------------------------------------------------------------
Logs are generated in directory /home/oracle/database/oracle11g/product/11.2.0/dbhome_1/localhost_orcl/sysman/log

```
