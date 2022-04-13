#!/usr/bin/sh
cd ${NGINX_HOME}
NGXSRC=nginxrc
mkdir -p ${NGXSRC}
ls -1 | grep -v ${NGXSRC} | xargs -I {} mv {} ./${NGXSRC}
cd ${NGXSRC}
./configure --prefix=${NGINX_HOME} && make && make install

