# Arch 安装配置

## 一.下载镜像

- Arch镜像下载地址
  - [http://mirrors.163.com/archlinux/iso/](http://mirrors.163.com/archlinux/iso/)

## 二. 刻录镜像到U盘

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

## 三.以 U 盘的形式启动电脑

- 每个电脑进入 BIOS 的方式不同，根据自己的实际情况 自行 Google 。

## 配置ssh

```bash
sudo pacman -S openssh
ssh-keygen -t rsa -C "your_email@example.com"
```
