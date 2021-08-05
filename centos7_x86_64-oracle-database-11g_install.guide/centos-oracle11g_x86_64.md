# Centos7 Oracle 11g x86_64 安装手册

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

### 5.安装数据库
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
---
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

---

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
# 查看本机 ip 
ifconfig

```

###### 重启

```bash
reboot
```
