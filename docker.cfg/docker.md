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
    sudo docker update --restart=always [CONTAINER ID] # 容器ida
    # 进入 mysql 命令行
    sudo docker exec -it mysql /bin/bash
    # 登陆 mysql
    mysql -u root -p [PASSWORD] # 启动 mysql 时 设置的密码
```

## Docker Oracle
```bash
    # 搜索 Oracle 镜像
    sudo docker search docker-oracle-xe-11g

    # 拉取 Oracle 镜像
    sudo docker pull deepdiver/docker-oracle-xe-11g

    # 运行 Oracle 
    sudo docker run -tid --name oracle -p 1521:1521  deepdiver/docker-oracle-xe-11g

    # 设置 容器自动启动
    sudo docker update --restart=always [CONTAINER ID] # 容器ida

    # 进入 Oracle 命令行
    sudo docker exec -it oracle /bin/bash

    #登陆 Oracle
    sqlplus system/oracle

    #查看用户
    select username, password from dba_users;

    #创建用户 SCOTT
    create user SCOTT identified by final;

    #查看是否有 SCOTT 用户
    select * from all_users;

    #给新用户授权
    grant connect,resource to SCOTT;
```