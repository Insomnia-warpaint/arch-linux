#!/usr/bin/sh
MYSQL_USER=mysql
MYSQL_PORT=(3306)
CONF_PATH=/etc/my.cnf
ROOT_PASSWD=final1234!
MYSQL_LOG_PATH=${MYSQL_HOME}/mysqld_multi.log
useradd -M -s /usr/bin/false ${MYSQL_USER} 2> /dev/null
mkdir -p ${MYSQL_BASE_DIR}

chown  ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_BASE_DIR}
for (( i = 0; i < ${#MYSQL_PORT[@]}; i++ ));
do
	firewall-cmd --zone=public --add-port=${MYSQL_PORT[i]}/tcp --permanent
	firewall-cmd --reload
	mkdir -p ${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/data
	touch ${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/error_${MYSQL_PORT[i]}.log
	chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/data
	
done

cd ${MYSQL_HOME}/${MysqlBin}
for ex in `ls -1`;
do
	if [[ -x $ex ]] && [[ -f $ex ]]; then
		
		chown -R ${MYSQL_USER}:${MYSQL_USER} /usr/bin/${ex}
		chmod 755 /usr/bin/$ex
	fi
done

touch ${CONF_PATH}
dd if=/dev/null of=${CONF_PATH}
tee  ${CONF_PATH} << EOF
[mysqld]
user=${MYSQL_USER}
basedir=${MYSQL_HOME}

[mysqld_multi]
mysqld=${MYSQL_HOME}/${MysqlBin}/mysqld_safe
mysqladmin=${MYSQL_HOME}/${MysqlBin}/mysqladmin
log=${MYSQL_LOG_PATH}
user=root
pass=${ROOT_PASSWD}
EOF



for (( i = 0; i < ${#MYSQL_PORT[@]}; i++ ));
do
tee -a ${CONF_PATH} << EOF

[mysqld${MYSQL_PORT[i]}]
mysqld=mysqld
mysqladmin=mysqladmin
datadir=${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/data
port=${MYSQL_PORT[i]}
server_id=${MYSQL_PORT[i]}
log-error=${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/error_${MYSQL_PORT[i]}.log
socket=/tmp/mysql_${MYSQL_PORT[i]}.sock
character-set-server=utf8mb4
default-storage-engine=INNODB
group_concat_max_len=-1
EOF
done

MYSQL_SERVICE=/etc/init.d/mysql
touch ${MYSQL_SERVICE}
chmod +x ${MYSQL_SERVICE}
dd if=/dev/null of=${MYSQL_SERVICE}
tee ${MYSQL_SERVICE} << EOF 
#!/bin/sh

basedir=${MYSQL_HOME}
bindir=${MYSQL_HOME}/${MysqlBin}

if test -x \$bindir/mysqld_multi
then
  mysqld_multi="\$bindir/mysqld_multi";
else
  echo "Can't execute \$bindir/mysqld_multi from dir \$basedir";
  exit;
fi

case "\$1" in
    'start' )
        "\$mysqld_multi" start \$2
        ;;
    'stop' )
        "\$mysqld_multi" stop \$2
        ;;
    'report' )
        "\$mysqld_multi" report \$2
        ;;
    'restart' )
        "\$mysqld_multi" stop \$2
        "\$mysqld_multi" start \$2
        ;;
    *)
        echo "Usage: \$0 {start|stop|report|restart}" >&2
        ;;
esac
EOF

INIT_SQL=init_mysql.sql
SQL_PATH=${MYSQL_HOME}/${INIT_SQL}
touch ${SQL_PATH}
chmod +x ${SQL_PATH}
dd if=/dev/null of=${SQL_PATH}
tee ${SQL_PATH} << EOF
alter user 'root'@'localhost' identified by '${ROOT_PASSWD}';
grant all privileges on *.* to 'root'@'%' identified by '${ROOT_PASSWD}' with grant option;
flush privileges;
show grants for root;
select user,authentication_string,plugin,host from mysql.user;
EOF

chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_HOME}
chown -R ${MYSQL_USER}:${MYSQL_USER} ${MYSQL_BASE_DIR}
for (( i = 0; i < ${#MYSQL_PORT[@]}; i++ ));
do

INIT_SH=${MYSQL_HOME}/init_mysql_${MYSQL_PORT[i]}.sh
touch ${INIT_SH}
chmod +x ${INIT_SH}
dd if=/dev/null of=${INIT_SH}

tee ${INIT_SH} << EOF
#!/usr/bin/sh
case \$1 in
  '-p')
        ${MYSQL_HOME}/${MysqlBin}/mysql -h127.0.0.1 -P${MYSQL_PORT[i]} -uroot -Dmysql -p\$2 --connect-expired-password  < ${SQL_PATH} && \\
        ${MYSQL_HOME}/${MysqlBin}/mysqladmin -h127.0.0.1 -P${MYSQL_PORT[i]} -uroot shutdown && \\
        ${MYSQL_HOME}/${MysqlBin}/mysqld_multi start ${MYSQL_PORT[i]}
        ${MYSQL_HOME}/${MysqlBin}/mysqld_multi report
     ;;
esac
EOF

echo ${MYSQL_HOME}/${MysqlBin}/mysqld --defaults-file=/etc/my.cnf --initialize --basedir=${MYSQL_BASE_DIR} --datadir=${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/data
${MYSQL_HOME}/${MysqlBin}/mysqld --defaults-file=/etc/my.cnf --initialize --basedir=${MYSQL_BASE_DIR} --datadir=${MYSQL_BASE_DIR}/${MYSQL_PORT[i]}/data
echo "#################################上方root@localhost后面的随即字符串为${MYSQL_PORT[i]}实例的root的初始密码###########################"
${MYSQL_HOME}/${MysqlBin}/mysqld_multi start ${MYSQL_PORT[i]}

read -p "请输入${MYSQL_PORT[i]}实例的密码:" pass
sh ${INIT_SH} -p ${pass}
${MYSQL_HOME}/${MysqlBin}/mysqld_multi report

#echo "#######################################"
#echo "#若mysql未启动,请执行命令:            #"
#echo "#1.mysqld_multi start ${MYSQL_PORT[i]}         #"
#echo "#2.mysqld_multi report                #"
#echo "#######################################"
#echo "###################################################################################"
#echo "#请执行命令:                                      #"
#echo "###################################sh ${INIT_SH} -p '初始密码'###############################"
#echo "#提示:  "
#echo "#1. 请输入对应实例的密码                                          #"
#echo "#2. 密码前后需要有单引号                                          #"
#echo "#3. <初始密码> 为上方mysql日志中最后一行:  root@localhost:后面的随机字符串          #"
#echo "###################################################################################"

done

mysql_help=${MYSQL_HOME}/mysql_help.md
touch ${mysql_help}
dd if=/dev/null of=${mysql_help}
echo "###################################################tip##############################################" 
echo "########################启动所有实例: service mysql start###########################################"
echo "########################停止所有实例: service mysql stop############################################"
for (( i = 0; i < ${#MYSQL_PORT[@]}; i++));
do
echo "########################停止${MYSQL_PORT[i]}实例: service mysql stop ${MYSQL_PORT[i]}#############################"
done
echo "####################################################################################################"
chown mysql:mysql ${mysql_help}
chmod 777 ${mysql_help}
