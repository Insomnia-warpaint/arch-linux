## Docker开启Remote API 访问 2375端口 
```vim
# vim /usr/lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock
```

## Docker mysql
```bash
    # 拉取 mysql:8.0 镜像
    sudo docker pull mysql:8.0
    # 运行 mysql:8.0 
    sudo docker run -tid --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD = [PASSWORD]  mysql:8.0
    # 设置 容器自动启动
    sudo docker update --restart=always [CONTAINER ID] # 容器id
    # 进入 mysql 命令行
    sudo docker exec -it mysql /bin/bash
    # 登陆 mysql
    mysql -u root -p [PASSWORD] # 启动 mysql 时 设置的密码
```

## Docker Oracle
拉取 oralce docker github 到本地
```bash
git clone https://github.com/oracle/docker-images.git 
```
进入 oracledatabase SingleInstance 目录
```bash
cd ./docker-images/OracleDatabase/SingleInstance
```
点击 readme.md 中的[`Oracle Technology Network`](https://www.oracle.com/database/technologies/oracle-database-software-downloads.htmla)下载 对应版本的二进制文件放入 dockerFile 对应版本的文件夹中
运行 ./buildContainerImage.sh -h
```bash
./buildContainerImage.sh -h

./buildContainerImage.sh -e -v 19.3.0 -o '--build-arg SLIMMING=false'
```
等待oracle安装完成，再运行oracle
```bash
docker run --name oracle \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_SID=orcl \
-e ORACLE_PWD=<your database passwords> \
oracle/database:19.3.0-ee
```
运行成功之后进入 oracle 容器命令行，使用 sqlplus 登陆数据库创建用户
```bash
sudo docker exec -it [container name] /bin/bash
#有三种连接方式
#SID 是oracle 启动时 设置的SID ，也有默认的SID , 最好自己设置
# 密码也是 oracle 启动是设置的密码 也有默认密码，最好自己设置
sqlplus sys/<your password>@//localhost:1521/<your SID> as sysdba
sqlplus system/<your password>@//localhost:1521/<your SID>
sqlplus pdbadmin/<your password>@//localhost:1521/<Your PDB name>
#创建用户 SCOTT
create user c##SCOTT identified by final;

#给新用户授权
grant dba,connect,resource to c##SCOTT;
```
