#!/usr/bin/sh




check_depend()
{

    if [[ ! -f ${BuildTemp} ]]; then
        yum install -y gcc glibc-devel make ncurses-devel openssl openssl-devel pcre pcre-devel perl wget xmlto zlib zlib-devel libaio
        echo 'gcc glibc-devel make ncurses-devel openssl openssl-devel pcre pcre-devel perl wget xmlto zlib zlib-devel libaio' >> ${BuildTemp}
    fi

}


exec_hook()
{
    isexists "${CurrentDir}" "-d"

    if [[ '0' -eq $? ]]; then
	echo "environment variable CurrentDir not exists"
	exit
    fi

    chmod -R +x ${CurrentDir}/hook 	

    case $2 in

	'-b')
    		cd "${CurrentDir}"/hook/before/
	;;

	'-a')
    		cd "${CurrentDir}"/hook/after/
	;;

    esac	

    eval $1

    if [[ $? -eq "0" ]]; then

       return '1'
    
    else

       return '0'
    fi

}


build_before()
{

	check_depend

	if [[ $1 =~ ${NGINX_HOME} ]]; then

		exec_hook "sh "${NginxName}".sh" "-b"
	fi

	if [[ $1 =~ ${ERLANG_HOME} ]]; then

		exec_hook "sh "${ErlangName}".sh" "-b"
	fi

}


function build_after()
{
	
	if [[ $1 =~ ${MONGODB_HOME} ]]; then
		exec_hook "sh "${MongodbName}".sh" "-a"
		
	fi

	if [[ $1 =~ ${INFLUXDB_HOME} ]]; then

		exec_hook "sh "${InfluxdbName}".sh" "-a"
	fi
	
	if [[ $1 =~ ${MQ_HOME} ]]; then

		exec_hook "sh "${MQName}".sh" "-a"
	fi
	
	
	if [[ $1 =~ ${MYSQL_HOME} ]]; then

		exec_hook "sh "${MysqlName}".sh" "-a"
	fi

        echo $1 >> ${BuildTemp}

}


function extractive()
{
    ExtraTmp=${CurrentDir}/temp
    mkdir -p ${ExtraTmp}
    TarArr_extra=(`echo $1`)
    HomeArr_extra=(`echo $2`)
    DirNameArr_extra=(`echo $3`)
    BinArr_extra=(`echo $4`)
    Len_extra=$5
    for (( i = 0; i < "${Len_extra}"; i++ ));
    do
	    isexists "${HomeArr_extra[i]}" "-d"

        if [[ ! '1' -ne $? ]]; then
            echo "${HomeArr_extra[i]}" exists
            continue
        fi

        if [[ ${TarArr_extra[i]} =~ \.tar$ ]]; then

             echo extract "${TarArr_extra[i]}" to "${HomeArr_extra[i]}"
             tar -xvf ${TarArr_extra[i]} -C ${ExtraTmp}

        fi

        if [[ ${TarArr_extra[i]} =~ \.tgz$ ]]; then

             echo extract "${TarArr_extra[i]}" to "${HomeArr_extra[i]}"
             tar -xvf ${TarArr_extra[i]} -C ${ExtraTmp}

        fi

        if [[ ${TarArr_extra[i]} =~ \.tar\.gz$ ]]; then

             echo extract "${TarArr_extra[i]}" to "${HomeArr_extra[i]}"
             tar -xvf ${TarArr_extra[i]} -C ${ExtraTmp}


        fi

        if [[ ${TarArr_extra[i]} =~ \.tar\.xz$ ]]; then

             echo extract "${TarArr_extra[i]}" to "${HomeArr_extra[i]}"
             tar -xvf ${TarArr_extra[i]} -C ${ExtraTmp}


        fi

        if [[ ${TarArr_extra[i]} =~ \.zip$ ]]; then

             echo extract "${TarArr_extra[i]}" to "${HomeArr_extra[i]}"
             unzip -d ${ExtraTmp} ${TarArr_extra[i]}

        fi

#       echo rename ${ExtraTmp}/`ls -1 ${ExtraTmp}` ${ExtraTmp}/${DirNameArr_extra[i]} ${ExtraTmp}/`ls -1 ${ExtraTmp}`
#       rename ${ExtraTmp}/`ls -1 ${ExtraTmp}` ${ExtraTmp}/${DirNameArr_extra[i]} ${ExtraTmp}/`ls -1 ${ExtraTmp}`
	echo mv ${ExtraTmp}/`ls -1 ${ExtraTmp}` ${HomeArr_extra[i]}
	mv ${ExtraTmp}/`ls -1 ${ExtraTmp}` ${HomeArr_extra[i]}
	chown -R ${USER}:${USER} ${HomeArr_extra[i]}
    done

	rm -r ${ExtraTmp}

}


 build_application()
{
    usr_bin=/usr/bin
    TarArr_build=(`echo $1`)
    HomeArr_build=(`echo $2`)
    DirNameArr_build=(`echo $3`)
    BinArr_build=(`echo $4`)
    Len_build=$5
    touch ${BuildTemp}
    for (( i = 0; i < $5; i++ ));
    do

        ## 目录下有可执行文件返回 1
        childisexec "${HomeArr_build[i]}/${BinArr_build[i]}"

        if [[ '0' -eq $? ]]; then

            build_before "${HomeArr_build[i]}/${BinArr_build[i]}"

            if [[ '0' -eq $? ]]; then
             continue
            fi
        fi

        cd ${HomeArr_build[i]}/${BinArr_build[i]}

        for ex in `ls -1`; do

            ln -sf ${HomeArr_build[i]}/${BinArr_build[i]}/${ex} ${usr_bin}/${ex}

        done
	
	AppIsBuild=`grep ${HomeArr_build[i]}/${BinArr_build[i]} ${BuildTemp} | wc -l`

	if [[ '0' -eq ${AppIsBuild} ]]; then
		build_after "${HomeArr_build[i]}/${BinArr_build[i]}"
	fi


    done

}


function run()
{

    #check_depend
    mkdir -p ${RootDir}
    HISTFILESIZE=99999
    HISTSIZE=99999 

    if [[ $# -ne '8' ]]; then

        echo "参数不足,或参数错误 请传入4组参数, 每组分别为数组和数组的长度, 4个数组的长度必须一样,并且数组索引一一对应"
        return '0'
    fi

    if [[ $2 -eq $4  ]] && [[ $2 -eq $6  ]] && [[ $2 -eq $8  ]] && [[ $4 -eq $6  ]] && [[ $4 -eq $8  ]] && [[ $6 -eq $8  ]]; then
          # 参数1为压缩包路径数组
          # 参数3为解压路径数组
          # 参数5为解压路径文件夹名称
          # 参数7为解压安装包在解压文件夹下的bin路径
          TarArr_ini=(`echo $1`)
          HomeArr_ini=(`echo $3`)
          DirNameArr_ini=(`echo $5`)
          BinArr_ini=(`echo $7`)
          Len_ini=$8
          extractive "${TarArr_ini[*]}" "${HomeArr_ini[*]}" "${DirNameArr_ini[*]}" "${BinArr_ini[*]}" "${Len_ini}"
          build_application "${TarArr_ini[*]}" "${HomeArr_ini[*]}" "${DirNameArr_ini[*]}" "${BinArr_ini[*]}" "${Len_ini}"
          return '1'
    fi

    echo '4个数组长度不一致, 请检查!'

    return '0'
}



ITEM="{jdk|nginx|mongodb|influxdb|mysql|erland|rabbitmq}"

function case_build()
{
case $1 in

   'jdk')
  	echo build_application "${JDKPath}" "${JDK_HOME}" "${JDKName}" "${JDKBin}" "1"
  	build_application "${JDKPath}" "${JDK_HOME}" "${JDKName}" "${JDKBin}" "1"
    ;;

   'nginx')
  	echo build_application "${NginxPath}" "${NGINX_HOME}" "${NginxName}" "${NginxBin}" "1"
  	build_application "${NginxPath}" "${NGINX_HOME}" "${NginxName}" "${NginxBin}" "1"
    ;;

   'mongodb')
  	echo build_application "${MongoPath}" "${MONGODB_HOME}" "${MongodbName}" "${MongodbBin}" "1"
  	build_application "${MongoPath}" "${MONGODB_HOME}" "${MongodbName}" "${MongodbBin}" "1"
    ;;

   'influxdb')
  	echo build_application "${InfluxPath}" "${INGLUXDB_HOME}" "${InfluxdbName}" "${InfluxdbBin}" "1"
  	build_application "${InfluxPath}" "${INGLUXDB_HOME}" "${InfluxdbName}" "${InfluxdbBin}" "1"
    ;;

   'mysql')
  	echo build_application "${MysqlPath}" "${MYSQL_HOME}" "${MysqlName}" "${MysqlBin}" "1"
  	build_application "${MysqlPath}" "${MYSQL_HOME}" "${MysqlName}" "${MysqlBin}" "1"
    ;;

   'erlang')
  	echo build_application "${ErlangPath}" "${ERLANG_HOME}" "${ErlangName}" "${ErlangBin}" "1"
  	build_application "${ErlangPath}" "${ERLANG_HOME}" "${ErlangName}" "${ErlangBin}" "1"
    ;;

   'rabbitmq')
  	echo build_application "${MQPath}" "${MQ_HOME}" "${MQName}" "${MQBin}" "1"
  	build_application "${MQPath}" "${MQ_HOME}" "${MQName}" "${MQBin}" "1"
    ;;
    *)
	echo "$0 ${ITEM}" >&2	
    ;;
esac

}


function case_extra()
{
case $1 in

   'jdk')
  	echo extractive "${JDKPath}" "${JDK_HOME}" "${JDKName}" "${JDKBin}" "1"
  	extractive "${JDKPath}" "${JDK_HOME}" "${JDKName}" "${JDKBin}" "1"
    ;;

   'nginx')
   
  	echo extractive "${NginxPath}" "${NGINX_HOME}" "${NginxName}" "${NginxBin}" "1"
  	extractive "${NginxPath}" "${NGINX_HOME}" "${NginxName}" "${NginxBin}" "1"
    ;;

   'mongodb')
  	echo extractive "${MongoPath}" "${MONGODB_HOME}" "${MongodbName}" "${MongodbBin}" "1"
  	extractive "${MongoPath}" "${MONGODB_HOME}" "${MongodbName}" "${MongodbBin}" "1"
    ;;

   'influxdb')
  	echo extractive "${InfluxPath}" "${INGLUXDB_HOME}" "${InfluxdbName}" "${InfluxdbBin}" "1"
  	extractive "${InfluxPath}" "${INGLUXDB_HOME}" "${InfluxdbName}" "${InfluxdbBin}" "1"
    ;;

   'mysql')
  	echo extractive "${MysqlPath}" "${MYSQL_HOME}" "${MysqlName}" "${MysqlBin}" "1"
  	extractive "${MysqlPath}" "${MYSQL_HOME}" "${MysqlName}" "${MysqlBin}" "1"
    ;;

   'erlang')
  	echo extractive "${ErlangPath}" "${ERLANG_HOME}" "${ErlangName}" "${ErlangBin}" "1"
  	extractive "${ErlangPath}" "${ERLANG_HOME}" "${ErlangName}" "${ErlangBin}" "1"
    ;;

   'rabbitmq')
  	echo extractive "${MQPath}" "${MQ_HOME}" "${MQName}" "${MQBin}" "1"
  	extractive "${MQPath}" "${MQ_HOME}" "${MQName}" "${MQBin}" "1"
    ;;

    *)
	echo "$0 ${ITEM}" >&2	
    ;;
esac

}

