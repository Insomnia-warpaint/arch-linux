### 切换静态ip
 发行版: CentOS7
- 方法1:
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
	<br> 这种方法不是持久的,开机后就失效了
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
