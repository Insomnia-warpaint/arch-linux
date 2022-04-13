#!/usr/bin/sh
MONGO_USER=mongod
mkdir -p ${MONGODB_DATA_DIR}
useradd -M -s /usr/bin/false ${MONGO_USER} 2> /dev/null
chown -R ${MONGO_USER}:${MONGO_USER} ${MONGODB_HOME}

cd ${MONGODB_HOME}/${MongodbBin}
for ex in `ls -1`;
do
	if [[ -x $ex ]] && [[ -f $ex ]]; then
		
		chown -R ${MONGO_USER}:${MONGO_USER} /usr/bin/${ex}
		chmod 755 /usr/bin/$ex
	fi
done
dbpath=/opt/mongodb/mongodata
port=27017
logpath=${dbpath}/mongodb.log
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --reload
service_name=mongodb.service
service_path=${MONGODB_HOME}/${service_name}
touch ${service_path}
dd if=/dev/null of=${service_path}
tee ${service_path} << EOF
[Unit]
Description=mongodb-service
After=network.target

[Service]
User=mongod
Group=mongod
Type=forking
ExecStart=${MONGODB_HOME}/${MongodbBin}/mongod --dbpath=${dbpath} --port=${port} --storageEngine wiredTiger --logpath=${logpath} --bind_ip=0.0.0.0 --fork
ExecStop=${MONGODB_HOME}/${MongodbBin}/mongod --shutdown --dbpath=${dbpath}
Restart=on-failure
PrivateTmp=true

[Install]
WantedBy=multi-user.target
Alias=mongodb.service
EOF

mv -f ${service_path} /usr/lib/systemd/system
systemctl daemon-reload && \
systemctl enable ${service_name} && \
systemctl start ${service_name} && \
${MONGODB_HOME}/${MongodbBin}/mongo <<EOF
use admin;
db.createUser({
    user: "root",
    pwd: "final1234!",
    roles: [{ role : "root", db : "admin"}]
});

db.createUser({
    user: "hdkj",
    pwd: "Hdkj1234!",
    roles: [{ role : "root", db : "admin"}]
});
EOF
sed "9s/$/ --auth/g" /usr/lib/systemd/system/mongodb.service > ${service_path}
cp -f ${service_path} /usr/lib/systemd/system
systemctl daemon-reload && \
systemctl enable ${service_name} && \
systemctl start ${service_name}
