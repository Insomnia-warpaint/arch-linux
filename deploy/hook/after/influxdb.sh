#!/usr/bin/sh
INFLUX_USER=influxdb
META_DIR=${INFLUX_BASE_DIR}/meta 
DATA_DIR=${INFLUX_BASE_DIR}/data 
WAL_DIR=${INFLUX_BASE_DIR}/wal 
CONF_PATH=${ConfigDir}/${INFLUX_USER}.conf

cp ${CONF_PATH} ${INFLUXDB_HOME}
mkdir -p ${INFLUX_BASE_DIR}
mkdir -p ${META_DIR}
mkdir -p ${DATA_DIR}
mkdir -p ${WAL_DIR}

useradd -M -s /usr/bin/false ${INFLUX_USER} 2> /dev/null
chown  ${INFLUX_USER}:${INFLUX_USER} ${INFLUXDB_HOME}
chown  ${INFLUX_USER}:${INFLUX_USER} ${INFLUX_BASE_DIR}
chown  ${INFLUX_USER}:${INFLUX_USER} ${META_DIR}
chown  ${INFLUX_USER}:${INFLUX_USER} ${DATA_DIR}
chown  ${INFLUX_USER}:${INFLUX_USER} ${WAL_DIR}

cd ${INFLUXDB_HOME}/${InfluxdbBin}
for ex in `ls -1`;
do
	if [[ -x $ex ]] && [[ -f $ex ]]; then
		
		chown -R ${INFLUX_USER}:${INFLUX_USER} /usr/bin/${ex}
		chmod 755 /usr/bin/$ex
	fi
done
