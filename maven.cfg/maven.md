#  maven 配置
- 安装maven
```bash
# maven 的安装目录 ： /opt/maven
sudo pacman -S maven
```

- 修改maven配置文件
```bash
cd /opt/maven/conf
sudo vim settings.xml
```
```xml
<!-- 添加本地 maven 仓库存储路径-->
<localRepository>/home/insomnia/.m2/repository</localRepository>
<!-- 在 mirrors 节点添加阿里云 maven 仓库 -->
<mirrors>
    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
</mirrors>
```
```bash
# 创建 .m2 目录
mkdir ~/.m2
# 复制 settings.xml 到 .m2 目录下
sudo cp -r /opt/maven/conf/settings.xml  ~/.m2
```
## finish!