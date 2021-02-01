# Linux java 配置
- 下载jdk:
<br> [JDK15地址](https://www.oracle.com/java/technologies/javase-jdk15-downloads.html)
<br> [JDK8地址](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html)
- 创建jdk存放目录，然后解压jdk:
```bash
mkdir -p ~/dev/environment/java
cd ~/download/
tar -zxvf [jdk文件夹名] -C ~/dev/environment/java/ 
```
- 配置环境变量
```bash
sudo vim /etc/profile
GG定位到最后一行，zz 使光标所处行在屏幕中间，o 另起一行进行插入
export JAVA_HOME=/home/insomnia/dev/environment/java/jdk-8
export PATH=$PAHT:$JAVA_HOME/bin
按<Esc> ZZ(大写) 保存并退出
source /etc/profile 刷新配置文件
如果没有效果，重启。
java -version
```


