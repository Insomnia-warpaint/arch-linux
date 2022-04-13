#!/usr/bin/sh
source ./config.sh

usrbin=/usr/bin
usrsysd=/etc/systemd/system/multi-user.target.wants
sysdhome=/usr/lib/systemd/system
case $1 in

   'jdk')
  	rm -rf ${JDK_HOME} 
	cat ${BuildTemp} | grep -n ${JDKName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
    ;;

   'nginx')
   
  	rm -rf ${NGINX_HOME} 
	cat ${BuildTemp} | grep -n ${NginxName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
    ;;

   'mongodb')
  	rm -rf ${MONGODB_HOME} 
	rm -rf ${MONGODB_DATA_DIR}
	cat ${BuildTemp} | grep -n ${MongodbName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
	if test -f ${sysdhome}/${MongodbName}.service
	then
		rm -rf ${sysdhome}/${MongodbName}	
	fi
    ;;

   'influxdb')
	rm -rf ${INFLUXDB_HOME}
	rm -rf ${INFLEX_BASE_DIR}
	cat ${BuildTemp} | grep -n ${InfluxdbName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
	if test -f ${sysdhome}/${InfluxdbName}.service
	then
		rm -rf ${sysdhome}/${InfluxdbName}	
	fi
    ;;

   'mysql')
    	rm -rf ${MYSQL_HOME} 
	rm -rf ${MYSQL_BASE_DIR}
	cat ${BuildTemp} | grep -n ${MysqlName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
    ;;

   'erlang')
  	rm -rf ${ERLANG_HOME} 
	cat ${BuildTemp} | grep -n ${ErlangName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
    ;;

   'rabbitmq')
  	rm -rf ${MQ_HOME} 
	cat ${BuildTemp} | grep -n ${MQName} | cut -d: -f1 | xargs -I {} sed -i '{}d' ${BuildTemp}
	if test -f ${sysdhome}/${MQName}.service
	then
		rm -rf ${sysdhome}/${MQName}	
	fi
    ;;
esac

systemctl daemon-reload

cd ${usrbin}
for ex in `ls -1`;
do
	stat -L ${usrbin}/${ex}	
	if [[ $? -eq '1' ]]; then
		unlink ${usrbin}/$ex
	fi
done

cd ${usrsysd}
for ex in `ls -1`;
do
	stat -L ${usrsysd}/${ex}	
	if [[ $? -eq '1' ]]; then
		unlink ${usrsysd}/$ex
	fi
done
