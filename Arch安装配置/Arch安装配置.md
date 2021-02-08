# Arch 安装配置

## 一.基本安装
#### 1.下载镜像

- arch镜像下载地址
  - [http://mirrors.163.com/archlinux/iso/](http://mirrors.163.com/archlinux/iso/)

#### 2. 刻录镜像到U盘

- Linux 下使用命令行将 iso 文件刻录到 u 盘

```bash
查看 U 盘的路径。
sudo fdisk -l

Disk /dev/sda：125 GiB，134217728000 字节，262144000 个扇区
磁盘型号：UDisk   
单元：扇区 / 1 * 512 = 512 字节
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节
磁盘标签类型：dos
磁盘标识符：0x00000000

设备       启动    起点    末尾    扇区 大小 Id 类型
/dev/sda1  *         64 6300795 6300732   3G  0 空
/dev/sda2       6300796 6308987    8192   4M ef EFI (FAT-12/16/32)


if 后面是 Arch 镜像文件的路径 of 后面是 U 盘的路径 
sudo dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync
bs=4M 指定一个较为合理的文件输入输出块大小。
status=progress 用来输出刻录过程总的信息。
oflag=sync 用来控制写入数据时的行为特征。确保命令结束时数据及元数据真正写入磁盘，而不是刚写入缓存就返回。

等待刻录完成。
```

#### 3.以 U 盘的形式启动电脑

- 每个电脑进入 BIOS 的方式不同，根据自己的实际情况 自行 Google 。
#### 4.检测是否以 UEFI 模式启动
```bash
 ls /sys/firmware/efi/efivars
```
若有目录显示出来，则是以 UEFI 模式启动的。
#### 5.连接网络
wifi连接:
```bash 
iwctl  #进入无线连接交互模式
device list #列出网卡名称
station wlan0 scan #扫描网络
station wlan0 get-networks #获取网络名称列表
station wlan0 connect [ WIFI名称 ] #进行连接 输入密码
exit #退出
```
#### 6.测试网络
```bash
ping www.baidu.com
PING www.wshifen.com (104.193.88.77) 56(84) 比特的数据。
64 比特，来自 104.193.88.77 (104.193.88.77): icmp_seq=1 ttl=45 时间=296 毫秒
64 比特，来自 104.193.88.77 (104.193.88.77): icmp_seq=2 ttl=45 时间=236 毫秒
64 比特，来自 104.193.88.77 (104.193.88.77): icmp_seq=4 ttl=45 时间=651 毫秒
64 比特，来自 104.193.88.77 (104.193.88.77): icmp_seq=5 ttl=45 时间=819 毫秒
64 比特，来自 104.193.88.77 (104.193.88.77): icmp_seq=6 ttl=45 时间=307 毫秒
^C
--- www.wshifen.com ping 统计 ---
已发送 7 个包， 已接收 5 个包, 28.5714% packet loss, time 6211ms
rtt min/avg/max/mdev = 235.766/461.889/819.178/230.630 ms
```
若有数据返回，则说明联网成功了，`Ctrl+c`结束当前命令
#### 7.更新系统时钟
```bash
timedatectl set-ntp true #将系统时间与网络时间同步
timedatectl status #查看同步状态
               Local time: 日 2021-02-07 11:34:29 CST
           Universal time: 日 2021-02-07 03:34:29 UTC
                 RTC time: 日 2021-02-07 03:34:29    
                Time zone: Asia/Shanghai (CST, +0800)
System clock synchronized: yes                       
              NTP service: active                    
          RTC in local TZ: no 
```
`System clock synchronized` 为 `yes` 和 `NTP service` 为 `active` 则表示同步成功。
#### 8.更换国内镜像源，提升下载速度
```bash
vim /etc/pacman.d/mirrorlist
vim 常用快捷键
j #光标下移  
k #光标上移
h #光标左移
l #光标右移
i #进入插入模式
<Esc> # 返回正常模式
dd #删除一行，并将删除的一行存入寄存器
p #粘帖
##                                                                                            
## Arch Linux repository mirrorlist
## Generated on 2020-12-05
##
Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch  #阿里云镜像源
Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch #中科大镜像源
Server = http://mirrors.163.com/archlinux/$repo/os/$arch #网易镜像源
## Worldwide
...
```
将以上三个镜像源添加到文件最前面, `j`将光标移动到空行,`i`进入插入模式，输入镜像源，`<Esc>` , 返回正常模式`:wq`(冒号)wq 保存退出。
#### 9. 分区
- 根目录: 10G `系统目录 使用镜像源下载的软件都会放在系统目录下，若需要下载比较多的软件，建议多分一点。`
- EFI 目录: 500M 的引导目录
- swap 分区: `交换分区,一般为运行内存大小的一半，如果内存超过8G ，建议分为内存大小+2G 的大小`
- home 目录: 越大越好。`/home` `存放自己下载的软件，资料等，相当于 WIN 中的文件盘`
```bash
fdisk -l #查看分区
Disk /dev/nvme0n1：931.51 GiB，1000204886016 字节，1953525168 个扇区
磁盘型号：WDC WDS100T2B0C-00PXH0
单元：扇区 / 1 * 512 = 512 字节
扇区大小(逻辑/物理)：512 字节 / 512 字节
I/O 大小(最小/最佳)：512 字节 / 512 字节
磁盘标签类型：gpt
磁盘标识符：8F93E0B4-6D6B-8045-A88C-790DBD48A266

设备                起点       末尾       扇区  大小 类型
/dev/nvme0n1p1      2048    1026047    1024000  500M EFI 系统
/dev/nvme0n1p2   1026048   38774783   37748736   18G Linux swap
/dev/nvme0n1p3  38774784  862955519  824180736  393G Linux 文件系统
/dev/nvme0n1p4 862955520 1953525134 1090569615  520G Linux home

# 进入磁盘进行分区
cfdisk /dev/nvme0n1 #如果是固态硬盘会显示nvme... 如果是普通硬盘，则会是sda...
----------------------------
新建分区(NEW) 
输入分区大小：500M <Enter>
类型(TYPE) EFI System
----------------------------
新建分区(NEW)
输入分区大小：8G <Enter>
类型(TYPE) swap
----------------------------
新建分区(NEW) 
输入分区大小：50G <Enter>
类型(TYPE) Linux System
----------------------------
新建分区(NEW)
输入分区大小：200G <Enter>
类型(TYPE) Linux home
----------------------------
写入(WRITE)
确认(yes)
退出(EXIT)
```
#### 10.格式化分区
```bash
fdisk -l #查看分区
设备                起点       末尾       扇区  大小 类型
/dev/nvme0n1p1      2048    1026047    1024000  500M EFI 系统
/dev/nvme0n1p2   1026048   38774783   37748736   18G Linux swap
/dev/nvme0n1p3  38774784  862955519  824180736  50G Linux 文件系统
/dev/nvme0n1p4 862955520 1953525134 1090569615  200G Linux home

#将根目录和 home 目录格式化成ext4
mkfs.ext4 /dev/nvme0n1p3
mkfs.ext4 /dev/nvme0n1p4
#格式化 EFI 分区
mkfs.vfat /dev/nvme0n1p1
#格式化 swap 分区
mkswap -f /dev/nvme0n1p2 
swapon /dev/nvme0n1p2 
```
#### 11.挂载分区
-  配置ssh

```bash
sudo pacman -S openssh
ssh-keygen -t rsa -C "your_email@example.com"
```
