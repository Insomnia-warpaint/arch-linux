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

- 创建 `oracle` 用户 `oinstall` 用户组 和 `dba` 用户组

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

###3.设置内核参数 (内核参数参照官方文档)
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
export ORACLE_HOME=$ORACLE_HOME/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
export PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/lib64

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

### 安装过程中遇到的问题
1. 设置完密码之后安装程序卡住了, 安装窗口变成一条竖线
 - 安装程序弹窗很小的原因是 GNOME 桌面的原因,换一个桌面系统就可以了,亲测 KDE 没有问题.
- 安装 `KDE plasma workspaces`  

```bash
# 没有切换到 root 用户 执行命令前面需要加 sudo
yum groupinstall "KDE Plasma Workspaces"
```
#####安装完成后

1.  Logout(左上角点击) 
2.  选择 oracle 用户 然后点击小齿轮
3.  选择 `kde plasma workspaces`
4.  输入密码
5.  打开 `konsole`  终端 (对着桌面右键)

```bash
cd ~/oracle11g_install/database
./runInstaller
```