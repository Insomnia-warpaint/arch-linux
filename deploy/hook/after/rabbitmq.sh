#/usr/bin/sh
set +e
SIGIN_ACCOUNT=admin
PASSWORD=final1234!
SECOND=5
firewall-cmd --zone=public --add-port=15672/tcp --permanent
firewall-cmd --zone=public --add-port=5672/tcp --permanent
firewall-cmd --reload
service_name=rabbitmq.service
service_path=${MQ_HOME}/${service_name}
touch ${service_path}
dd if=/dev/null of=${service_path}
tee ${service_path} << EOF
[Unit]
Description=rabbitmq-service
After=network.target

[Service]
User=root
Group=root
Type=forking
ExecStartPre=${MQ_HOME}/${MQBin}/rabbitmq-plugins enable rabbitmq_management
ExecStart=${MQ_HOME}/${MQBin}/rabbitmq-server -detached
ExecStop=${MQ_HOME}/${MQBin}/rabbitmqctl stop
Restart=on-failure
PrivateTmp=true

[Install]
WantedBy=multi-user.target
Alias=rabbitmq.service
EOF

cp -f ${service_path} /usr/lib/systemd/system
systemctl daemon-reload && \
systemctl enable ${service_name} && \
systemctl start ${service_name} && \
echo "rabbitMQ service started"

script_name=create_user.sh
script_path=${MQ_HOME}/${script_name}
touch ${script_path}
dd if=/dev/null of=${script_path}
tee ${script_path} << EOF
#!/usr/bin/sh
${MQ_HOME}/${MQBin}/rabbitmqctl add_user ${SIGIN_ACCOUNT} ${PASSWORD}
${MQ_HOME}/${MQBin}/rabbitmqctl set_user_tags ${SIGIN_ACCOUNT} administrator
${MQ_HOME}/${MQBin}/rabbitmqctl set_permissions -p "/" ${SIGIN_ACCOUNT} ".*" ".*" ".*"
${MQ_HOME}/${MQBin}/rabbitmqctl list_users
EOF
chmod +x ${script_path}
/usr/bin/sh ${script_path}


Down=5

for (( i = 0; i < ${SECOND}; i++ ));
do
	echo "${Down} 秒后自动创建用户"
	sleep 1
	((Down--))
done

sh ${script_path}

echo "##################提示###############"
echo "#若 MQ 用户创建失败                 #"
echo "#请检查MQ服务,并开启, 然后执行命令: #"
echo "#sh ${script_path}                  #"
echo "#####################################"
