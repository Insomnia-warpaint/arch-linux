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
-  **登陆到oracle 用户,不要用 su oracle (从root切换过去)**
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


#### 6.安装 oralce11g

- 可视化安装

```bash
cd ~/oracle11g_install/database
./runInstaller
```

-  可视化安装过程中遇到的问题
 1. 设置完密码之后安装程序卡住了, 安装窗口变成一条竖线
 - 安装程序弹窗很小是 GNOME 桌面的原因,换一个桌面系统就可以了,亲测 KDE 没有问题.
 - 安装 `KDE plasma workspaces`  

 ```bash
# 没有切换到 root 用户 执行命令前面需要加 sudo
yum groupinstall "KDE Plasma Workspaces"
 ```
- kde 安装完成后

 1.  `logout`(桌面右上角点击登出) 
 2.  选择 oracle 用户 然后点击小齿轮
 3.  选择 `kde plasma workspaces`
 4.  输入密码
 5.  打开 `konsole`  终端 (对着桌面右键,选择 konsole )

 ```bash
cd ~/oracle11g_install/database
./runInstaller
 ```

- 静默安装

```bash
# 静默安装是指安装时读取自定义配置文件进行安装
./runInstaller -silent -responseFile /home/oracle/oracle11g_install/database/db.rsp -ignorePrereq

# 安装时命令行日志如下(日志内容根据实际情况而定) 若安装有错误，命令行会显示错误日志或者去查看错误日志文件
Starting Oracle Universal Installer...
Checking Temp space: must be greater than 120 MB.   Actual 63576 MB    Passed
Checking swap space: must be greater than 150 MB.   Actual 3968 MB    Passed
Preparing to launch Oracle Universal Installer from /tmp/OraInstall2021-08-21_10-40-37PM. Please wait ...[oracle@localhost database]$ [WARNING] [INS-30011] The ADMIN password entered does not conform to the Oracle recommended standards.
   CAUSE: Oracle recommends that the password entered should be at least 8 characters in length, contain at least 1 uppercase character, 1 lower case character and 1 digit [0-9].
   ACTION: Provide a password that conforms to the Oracle recommended standards.
You can find the log of this install session at:
 /home/oracle/database/oraInventory/logs/installActions2021-08-21_10-40-37PM.log
The installation of Oracle Database 11g was successful.
Please check '/home/oracle/database/oraInventory/logs/silentInstall2021-08-21_10-40-37PM.log' for more details.

As a root user, execute the following script(s):
	1. /home/oracle/database/oraInventory/orainstRoot.sh
	2. /home/oracle/database/oracle11g/product/11.2.0/dbhome_1/root.sh

```
- 配置文件内容如下
 - 下方配置文件是笔者经过可视化安装后保存的配置
   - 全局数据库名 对应`listener`中的`service_name`服务名
   - SID 对应`listerer` 中的`listener_name`监听名
   - 改配置的时候两个名称最好一致

| 属性 | 释义 |
| :--: |:--:|
|ORACLE_HOSTNAME|主机名名称|
|UNIX_GROUP_NAME|UNIX组名称|
|INVENTORY_LOCATION|ORALCE安装信息目录|
|SELECTED_LANGUAGES|语言|
|ORACLE_HOME|数据库目录|
|ORACLE_BASE|ORACLE产品目录|
|oracle.install.db.InstallEdition|ORACLE安装版本|
|oracle.install.db.EEOptionsSelection|自定义安装`false/true`|
|oracle.install.db.DBA_GROUP|拥有dba权限的组名称|
|oracle.install.db.OPER_GROUP|拥有oper权限的组名称|
|oracle.install.db.isRACOneInstall|单实例安装`false/true`|
|oracle.install.db.config.starterdb.type|安装类型|
|oracle.install.db.config.starterdb.globalDBName|全局数据库名|
|oracle.install.db.config.starterdb.SID|sid名称|
|oracle.install.db.config.starterdb.characterSet|字符集|
|oracle.install.db.config.starterdb.password.ALL| 所有用户的初始密码|
|...|...|

 - 将下方的内容复制出来,然后新建db.rsp,粘帖进文件中进行静默安装

```rsp
####################################################################
## Copyright(c) Oracle Corporation 1998, 2013. All rights reserved.##
##                                                                ##
## Specify values for the variables listed below to customize     ##
## your installation.                                             ##
##                                                                ##
## Each variable is associated with a comment. The comment        ##
## can help to populate the variables with the appropriate        ##
## values.                                                        ##
##                                                                ##
## IMPORTANT NOTE: This file contains plain text passwords and    ##
## should be secured to have read permission only by oracle user  ##
## or db administrator who owns this installation.                ##
##                                                                ##
####################################################################

#-------------------------------------------------------------------------------
# Do not change the following system generated value. 
#-------------------------------------------------------------------------------
oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v11_2_0

#-------------------------------------------------------------------------------
# Specify the installation option.
# It can be one of the following:
#   - INSTALL_DB_SWONLY
#   - INSTALL_DB_AND_CONFIG
#   - UPGRADE_DB
#-------------------------------------------------------------------------------
oracle.install.option=INSTALL_DB_AND_CONFIG

#-------------------------------------------------------------------------------
# Specify the hostname of the system as set during the install. It can be used
# to force the installation to use an alternative hostname rather than using the
# first hostname found on the system. (e.g., for systems with multiple hostnames 
# and network interfaces)
#-------------------------------------------------------------------------------
ORACLE_HOSTNAME=localhost

#-------------------------------------------------------------------------------
# Specify the Unix group to be set for the inventory directory.  
#-------------------------------------------------------------------------------
UNIX_GROUP_NAME=oinstall

#-------------------------------------------------------------------------------
# Specify the location which holds the inventory files.
# This is an optional parameter if installing on
# Windows based Operating System.
#-------------------------------------------------------------------------------
INVENTORY_LOCATION=/home/oracle/database/oraInventory
#-------------------------------------------------------------------------------
# Specify the languages in which the components will be installed.             
# 
# en   : English                  ja   : Japanese                  
# fr   : French                   ko   : Korean                    
# ar   : Arabic                   es   : Latin American Spanish    
# bn   : Bengali                  lv   : Latvian                   
# pt_BR: Brazilian Portuguese     lt   : Lithuanian                
# bg   : Bulgarian                ms   : Malay                     
# fr_CA: Canadian French          es_MX: Mexican Spanish           
# ca   : Catalan                  no   : Norwegian                 
# hr   : Croatian                 pl   : Polish                    
# cs   : Czech                    pt   : Portuguese                
# da   : Danish                   ro   : Romanian                  
# nl   : Dutch                    ru   : Russian                   
# ar_EG: Egyptian                 zh_CN: Simplified Chinese        
# en_GB: English (Great Britain)  sk   : Slovak                    
# et   : Estonian                 sl   : Slovenian                 
# fi   : Finnish                  es_ES: Spanish                   
# de   : German                   sv   : Swedish                   
# el   : Greek                    th   : Thai                      
# iw   : Hebrew                   zh_TW: Traditional Chinese       
# hu   : Hungarian                tr   : Turkish                   
# is   : Icelandic                uk   : Ukrainian                 
# in   : Indonesian               vi   : Vietnamese                
# it   : Italian                                                   
#
# all_langs   : All languages
#
# Specify value as the following to select any of the languages.
# Example : SELECTED_LANGUAGES=en,fr,ja
#
# Specify value as the following to select all the languages.
# Example : SELECTED_LANGUAGES=all_langs  
#-------------------------------------------------------------------------------
SELECTED_LANGUAGES=en,zh_CN

#-------------------------------------------------------------------------------
# Specify the complete path of the Oracle Home. 
#-------------------------------------------------------------------------------
ORACLE_HOME=/home/oracle/database/oracle11g/product/11.2.0/dbhome_1

#-------------------------------------------------------------------------------
# Specify the complete path of the Oracle Base. 
#-------------------------------------------------------------------------------
ORACLE_BASE=/home/oracle/database/oracle11g

#-------------------------------------------------------------------------------
# Specify the installation edition of the component.                     
#                                                             
# The value should contain only one of these choices.        
#   - EE     : Enterprise Edition                                
#   - SE     : Standard Edition                                  
#   - SEONE  : Standard Edition One
#   - PE     : Personal Edition (WINDOWS ONLY)
#-------------------------------------------------------------------------------
oracle.install.db.InstallEdition=EE

#-------------------------------------------------------------------------------
# This variable is used to enable or disable custom install and is considered
# only if InstallEdition is EE.
#
#   - true  : Components mentioned as part of 'optionalComponents' property
#             are considered for install.
#   - false : Value for 'optionalComponents' is not considered.
#-------------------------------------------------------------------------------
oracle.install.db.EEOptionsSelection=false

#-------------------------------------------------------------------------------
# This property is considered only if 'EEOptionsSelection' is set to true 
#
# Description: List of Enterprise Edition Options you would like to enable.
#
#              The following choices are available. You may specify any
#              combination of these choices.  The components you choose should
#              be specified in the form "internal-component-name:version"
#              Below is a list of components you may specify to enable.
#        
#              oracle.oraolap:11.2.0.4.0 - Oracle OLAP
#              oracle.rdbms.dm:11.2.0.4.0 - Oracle Data Mining RDBMS Files
#              oracle.rdbms.dv:11.2.0.4.0- Oracle Database Vault option
#              oracle.rdbms.lbac:11.2.0.4.0 - Oracle Label Security
#              oracle.rdbms.partitioning:11.2.0.4.0 - Oracle Partitioning
#              oracle.rdbms.rat:11.2.0.4.0 - Oracle Real Application Testing
#-------------------------------------------------------------------------------
oracle.install.db.optionalComponents=

###############################################################################
#                                                                             #
# PRIVILEGED OPERATING SYSTEM GROUPS                                          #
# ------------------------------------------                                  #
# Provide values for the OS groups to which OSDBA and OSOPER privileges       #
# needs to be granted. If the install is being performed as a member of the   #
# group "dba", then that will be used unless specified otherwise below.       #
#                                                                             #
# The value to be specified for OSDBA and OSOPER group is only for UNIX based #
# Operating System.                                                           #
#                                                                             #
###############################################################################

#------------------------------------------------------------------------------
# The DBA_GROUP is the OS group which is to be granted OSDBA privileges.
#-------------------------------------------------------------------------------
oracle.install.db.DBA_GROUP=dba

#------------------------------------------------------------------------------
# The OPER_GROUP is the OS group which is to be granted OSOPER privileges.
# The value to be specified for OSOPER group is optional.
#------------------------------------------------------------------------------
oracle.install.db.OPER_GROUP=oper

#-------------------------------------------------------------------------------
# Specify the cluster node names selected during the installation.                                      
# Example : oracle.install.db.CLUSTER_NODES=node1,node2
#-------------------------------------------------------------------------------
oracle.install.db.CLUSTER_NODES=

#------------------------------------------------------------------------------
# This variable is used to enable or disable RAC One Node install.
#
#   - true  : Value of RAC One Node service name is used.
#   - false : Value of RAC One Node service name is not used.
#
# If left blank, it will be assumed to be false.
#------------------------------------------------------------------------------
oracle.install.db.isRACOneInstall=false

#------------------------------------------------------------------------------
# Specify the name for RAC One Node Service. 
#------------------------------------------------------------------------------
oracle.install.db.racOneServiceName=

#-------------------------------------------------------------------------------
# Specify the type of database to create.
# It can be one of the following:
#   - GENERAL_PURPOSE/TRANSACTION_PROCESSING                       
#   - DATA_WAREHOUSE                                
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.type=GENERAL_PURPOSE

#-------------------------------------------------------------------------------
# Specify the Starter Database Global Database Name. 
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.globalDBName=orcl

#-------------------------------------------------------------------------------
# Specify the Starter Database SID.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.SID=orcl

#-------------------------------------------------------------------------------
# Specify the Starter Database character set.
#                                               
#  One of the following
#  AL32UTF8, WE8ISO8859P15, WE8MSWIN1252, EE8ISO8859P2,
#  EE8MSWIN1250, NE8ISO8859P10, NEE8ISO8859P4, BLT8MSWIN1257,
#  BLT8ISO8859P13, CL8ISO8859P5, CL8MSWIN1251, AR8ISO8859P6,
#  AR8MSWIN1256, EL8ISO8859P7, EL8MSWIN1253, IW8ISO8859P8,
#  IW8MSWIN1255, JA16EUC, JA16EUCTILDE, JA16SJIS, JA16SJISTILDE,
#  KO16MSWIN949, ZHS16GBK, TH8TISASCII, ZHT32EUC, ZHT16MSWIN950,
#  ZHT16HKSCS, WE8ISO8859P9, TR8MSWIN1254, VN8MSWIN1258
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.characterSet=ZHS16GBK

#------------------------------------------------------------------------------
# This variable should be set to true if Automatic Memory Management 
# in Database is desired.
# If Automatic Memory Management is not desired, and memory allocation
# is to be done manually, then set it to false.
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.memoryOption=true

#-------------------------------------------------------------------------------
# Specify the total memory allocation for the database. Value(in MB) should be
# at least 256 MB, and should not exceed the total physical memory available 
# on the system.
# Example: oracle.install.db.config.starterdb.memoryLimit=512
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.memoryLimit=1508

#-------------------------------------------------------------------------------
# This variable controls whether to load Example Schemas onto
# the starter database or not.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.installExampleSchemas=false

#-------------------------------------------------------------------------------
# This variable includes enabling audit settings, configuring password profiles
# and revoking some grants to public. These settings are provided by default. 
# These settings may also be disabled.     
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.enableSecuritySettings=true

###############################################################################
#                                                                             #
# Passwords can be supplied for the following four schemas in the             #
# starter database:                                                           #
#   SYS                                                                       #
#   SYSTEM                                                                    #
#   SYSMAN (used by Enterprise Manager)                                       #
#   DBSNMP (used by Enterprise Manager)                                       #
#                                                                             #
# Same password can be used for all accounts (not recommended)                #
# or different passwords for each account can be provided (recommended)       #
#                                                                             #
###############################################################################

#------------------------------------------------------------------------------
# This variable holds the password that is to be used for all schemas in the
# starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.ALL=final

#-------------------------------------------------------------------------------
# Specify the SYS password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.SYS=

#-------------------------------------------------------------------------------
# Specify the SYSTEM password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.SYSTEM=

#-------------------------------------------------------------------------------
# Specify the SYSMAN password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.SYSMAN=

#-------------------------------------------------------------------------------
# Specify the DBSNMP password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.DBSNMP=

#-------------------------------------------------------------------------------
# Specify the management option to be selected for the starter database. 
# It can be one of the following:
#   - GRID_CONTROL
#   - DB_CONTROL
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.control=DB_CONTROL

#-------------------------------------------------------------------------------
# Specify the Management Service to use if Grid Control is selected to manage 
# the database.      
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.gridcontrol.gridControlServiceURL=

###############################################################################
#                                                                             #
# SPECIFY BACKUP AND RECOVERY OPTIONS                                         #
# ------------------------------------                                        #
# Out-of-box backup and recovery options for the database can be mentioned    #
# using the entries below.                                                    #
#                                                                             #
###############################################################################

#------------------------------------------------------------------------------
# This variable is to be set to false if automated backup is not required. Else 
# this can be set to true.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.automatedBackup.enable=false

#------------------------------------------------------------------------------
# Regardless of the type of storage that is chosen for backup and recovery, if 
# automated backups are enabled, a job will be scheduled to run daily to backup 
# the database. This job will run as the operating system user that is 
# specified in this variable.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.automatedBackup.osuid=

#-------------------------------------------------------------------------------
# Regardless of the type of storage that is chosen for backup and recovery, if 
# automated backups are enabled, a job will be scheduled to run daily to backup 
# the database. This job will run as the operating system user specified by the 
# above entry. The following entry stores the password for the above operating 
# system user.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.automatedBackup.ospwd=

#-------------------------------------------------------------------------------
# Specify the type of storage to use for the database.
# It can be one of the following:
#   - FILE_SYSTEM_STORAGE
#   - ASM_STORAGE
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE

#-------------------------------------------------------------------------------
# Specify the database file location which is a directory for datafiles, control
# files, redo logs.         
#
# Applicable only when oracle.install.db.config.starterdb.storage=FILE_SYSTEM_STORAGE 
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=/home/oracle/database/oracle11g/oradata

#-------------------------------------------------------------------------------
# Specify the backup and recovery location.
#
# Applicable only when oracle.install.db.config.starterdb.storage=FILE_SYSTEM_STORAGE 
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.fileSystemStorage.recoveryLocation=

#-------------------------------------------------------------------------------
# Specify the existing ASM disk groups to be used for storage.
#
# Applicable only when oracle.install.db.config.starterdb.storageType=ASM_STORAGE
#-------------------------------------------------------------------------------
oracle.install.db.config.asm.diskGroup=

#-------------------------------------------------------------------------------
# Specify the password for ASMSNMP user of the ASM instance.                 
#
# Applicable only when oracle.install.db.config.starterdb.storage=ASM_STORAGE 
#-------------------------------------------------------------------------------
oracle.install.db.config.asm.ASMSNMPPassword=

#------------------------------------------------------------------------------
# Specify the My Oracle Support Account Username.
#
#  Example   : MYORACLESUPPORT_USERNAME=abc@oracle.com
#------------------------------------------------------------------------------
MYORACLESUPPORT_USERNAME=

#------------------------------------------------------------------------------
# Specify the My Oracle Support Account Username password.
#
# Example    : MYORACLESUPPORT_PASSWORD=password
#------------------------------------------------------------------------------
MYORACLESUPPORT_PASSWORD=

#------------------------------------------------------------------------------
# Specify whether to enable the user to set the password for
# My Oracle Support credentials. The value can be either true or false.
# If left blank it will be assumed to be false.
#
# Example    : SECURITY_UPDATES_VIA_MYORACLESUPPORT=true
#------------------------------------------------------------------------------
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false

#------------------------------------------------------------------------------
# Specify whether user doesn't want to configure Security Updates.
# The value for this variable should be true if you don't want to configure
# Security Updates, false otherwise.
#
# The value can be either true or false. If left blank it will be assumed
# to be false.
#
# Example    : DECLINE_SECURITY_UPDATES=false
#------------------------------------------------------------------------------
DECLINE_SECURITY_UPDATES=true

#------------------------------------------------------------------------------
# Specify the Proxy server name. Length should be greater than zero.
#
# Example    : PROXY_HOST=proxy.domain.com 
#------------------------------------------------------------------------------
PROXY_HOST=

#------------------------------------------------------------------------------
# Specify the proxy port number. Should be Numeric and at least 2 chars.
#
# Example    : PROXY_PORT=25
#------------------------------------------------------------------------------
PROXY_PORT=

#------------------------------------------------------------------------------
# Specify the proxy user name. Leave PROXY_USER and PROXY_PWD
# blank if your proxy server requires no authentication.
#
# Example    : PROXY_USER=username
#------------------------------------------------------------------------------
PROXY_USER=

#------------------------------------------------------------------------------
# Specify the proxy password. Leave PROXY_USER and PROXY_PWD  
# blank if your proxy server requires no authentication.
#
# Example    : PROXY_PWD=password
#------------------------------------------------------------------------------
PROXY_PWD=

#------------------------------------------------------------------------------
# Specify the proxy realm. 
#
# Example    : PROXY_REALM=metalink
#------------------------------------------------------------------------------
PROXY_REALM=
#------------------------------------------------------------------------------
# Specify the Oracle Support Hub URL. 
# 
# Example    : COLLECTOR_SUPPORTHUB_URL=https://orasupporthub.company.com:8080/
#------------------------------------------------------------------------------
COLLECTOR_SUPPORTHUB_URL=

#------------------------------------------------------------------------------
# Specify the auto-updates option. It can be one of the following:
#   - MYORACLESUPPORT_DOWNLOAD
#   - OFFLINE_UPDATES
#   - SKIP_UPDATES
#------------------------------------------------------------------------------
oracle.installer.autoupdates.option=SKIP_UPDATES
#------------------------------------------------------------------------------
# In case MYORACLESUPPORT_DOWNLOAD option is chosen, specify the location where
# the updates are to be downloaded.
# In case OFFLINE_UPDATES option is chosen, specify the location where the updates 
# are present.
#------------------------------------------------------------------------------
oracle.installer.autoupdates.downloadUpdatesLoc=
#------------------------------------------------------------------------------
# Specify the My Oracle Support Account Username which has the patches download privileges  
# to be used for software updates.
#  Example   : AUTOUPDATES_MYORACLESUPPORT_USERNAME=abc@oracle.com
#------------------------------------------------------------------------------
AUTOUPDATES_MYORACLESUPPORT_USERNAME=

#------------------------------------------------------------------------------
# Specify the My Oracle Support Account Username password which has the patches download privileges  
# to be used for software updates.
#
# Example    : AUTOUPDATES_MYORACLESUPPORT_PASSWORD=password
#------------------------------------------------------------------------------
AUTOUPDATES_MYORACLESUPPORT_PASSWORD=

```

#### 接下来跟着引导程序走就可以完成安装了!

---

### 7.连接 oracle 数据库
- 开启1521端口

```bash
sudo irewall-cmd --zone=public --add-port=1521/tcp --permanent
# 重新加载
sudo firewall-cmd --reload
# 查看开放的端口
sudo firewall-cmd --list-ports
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
# 找到 ORACLE_HOME_LISTNER 变量,将 $1 改成 $ORACLE_HOME
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
sudo vim /etc/oratab
# 将 N 改为 Y
orcl:/home/oracle/database/oracle11g/product/11.2.0/dbhome_1:Y

```

- 修改 /etc/rc.d/rc.local

```bash
# 在内核初始化的时候后 init.d 文件夹下的配置
# 在系统初始化的时候会去读取 rc.d 文件夹下的配置
sudo vim /etc/rc.d/rc.loacl

# 将下面两行命令复制到 rc.local 文件中,然后保存

# 以 oracle 用户执行开启监听命令
su oracle -lc /home/oracle/database/oracle11g/product/11.2.0/dbhome_1/bin/lsnrctl start
# 以 oracle 用户执行启动数据库命令
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
CREATE USER SCOTT IDENTIFIED final；
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
sed -i 's/TABLESPACE "USERSO"/TABLESPACE "SCOTT_SPACE"/g' scott_bak.dmp
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
