#/usr/bin/sh
RootDir=/opt
TarDir=tar

JDKTarName=jdk-8u161-linux-x64.tar.gz
NginxTarName=nginx-1.20.2.tar.gz
MongodbTarName=mongodb-linux-x86_64-rhel70-3.6.23.tgz
InfluxdbTarName=influxdb-1.8.4_linux_amd64.tar.gz
MysqlTarName=mysql-5.7.37-linux-glibc2.12-x86_64.tar.gz
ErlangTarName=otp_src_24.3.3.tar.gz
MQTarName=rabbitmq-server-generic-unix-3.9.14.tar.xz

export JDKName=openjdk
export NginxName=nginx
export MongodbName=mongodb
export InfluxdbName=influxdb
export MysqlName=mysql
export ErlangName=erlang
export MQName=rabbitmq

export JDKBin=bin
export NginxBin=sbin
export MongodbBin=bin
export InfluxdbBin=usr/bin
export MysqlBin=bin
export ErlangBin=bin
export MQBin=sbin

export JDK_HOME=${RootDir}/${JDKName}
export NGINX_HOME=${RootDir}/${NginxName}
export MONGODB_HOME=${RootDir}/${MongodbName}
export INFLUXDB_HOME=${RootDir}/${InfluxdbName}
export MYSQL_HOME=${RootDir}/${MysqlName}
export ERLANG_HOME=${RootDir}/${ErlangName}
export MQ_HOME=${RootDir}/${MQName}

export JDKPath=${TarDir}/${JDKTarName}
export NginxPath=${TarDir}/${NginxTarName}
export MongoPath=${TarDir}/${MongodbTarName}
export InfluxPath=${TarDir}/${InfluxdbTarName}
export MysqlPath=${TarDir}/${MysqlTarName}
export ErlangPath=${TarDir}/${ErlangTarName}
export MQPath=${TarDir}/${MQTarName}


export CurrentDir=`pwd`
export ConfigDir=${CurrentDir}/configuration
export BuildTemp=/tmp/build.tmp


export MYSQL_BASE_DIR=/usr/local/mysql
export MONGODB_DATA_DIR=${MONGODB_HOME}/mongodata
export INFLUX_INFLUX_BASE_DIR=/data 


TarArr=(${JDKPath} ${NginxPath} ${MongoPath} ${InfluxPath} ${MysqlPath} ${ErlangPath} ${MQPath})
HomeArr=(${JDK_HOME} ${NGINX_HOME} ${MONGODB_HOME} ${INFLUXDB_HOME} ${MYSQL_HOME} ${ERLANG_HOME} ${MQ_HOME})
DirNameArr=(${JDKName} ${NginxName} ${MongodbName} ${InfluxdbName} ${MysqlName} ${ErlangName} ${MQName})
BinArr=(${JDKBin} ${NginxBin} ${MongodbBin} ${InfluxdbBin} ${MysqlBin} ${ErlangBin} ${MQBin})

#TarArr=(${JDKPath} ${ErlangPath} ${MQPath})
#HomeArr=(${JDK_HOME} ${ERLANG_HOME} ${MQ_HOME})
#DirNameArr=(${JDKName} ${ErlangName} ${MQName})
#BinArr=(${JDKBin} ${ErlangBin} ${MQBin})


#TarArr=(${MongoPath} ${InfluxPath} ${MysqlPath})
#HomeArr=(${MONGODB_HOME} ${INFLUXDB_HOME} ${MYSQL_HOME})
#DirNameArr=(${MongodbName} ${InfluxdbName} ${MysqlName})
#BinArr=(${MongodbBin} ${InfluxdbBin} ${MysqlBin})

#TarArr=(${JDKPath} ${NginxPath} ${MongoPath} ${InfluxPath} ${MysqlPath} ${ErlangPath} ${MQPath})
#HomeArr=(${JDK_HOME} ${NGINX_HOME} ${MONGODB_HOME} ${INFLUXDB_HOME} ${MYSQL_HOME} ${ERLANG_HOME} ${MQ_HOME})
#DirNameArr=(${JDKName} ${NginxName} ${MongodbName} ${InfluxdbName} ${MysqlName} ${ErlangName} ${MQName})
#BinArr=(${JDKBin} ${NginxBin} ${MongodbBin} ${InfluxdbBin} ${MysqlBin} ${ErlangBin} ${MQBin})
