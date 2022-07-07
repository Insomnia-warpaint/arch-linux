#!/bin/sh
set -e
echo "Welcome using CentOS oracle backup script"
DATE=`date +%Y%m%d`
echo $DATE

AGO_DATE=`date -d "7 days ago" +%Y%m%d `
echo $AGO_DATE

DMP_SUFFIX=.dmp
LOG_SUFFIX=.log
DMP_PATH=/home/oracle/oracle/backup/dmp
LOG_PATH=/home/oracle/oracle/backup/log
BUFFER_SIZE=20480000
RECODE_LENGTH=65535
ZIP_SUFFIX=.zip

################################### 用户名 密码  服务名 ####################################
UNAME=yhgl
PASSWD=yhgl 
SERVER_NAME=whzls
echo "username = $UNAME"
echo "passwd = $PASSWD"
echo "service_name = $SERVER_NAME"

#################################### owner #######################################
OWNER1=a
OWNER2=b
OWNER3=c
OWNER4=d
OWNER5=e
OWNER6=f
OWNER7=g
echo "owner1 = $OWNER1"
echo "owner2 = $OWNER2"
echo "owner3 = $OWNER3"
echo "owner4 = $OWNER4"
echo "owner5 = $OWNER5"
echo "owner6 = $OWNER6"
echo "owner7 = $OWNER7"


################################### file name ###########################################
FILE_PREFIX1=$OWNER1$DATE
FILE_PREFIX2=$OWNER2$DATE
FILE_PREFIX3=$OWNER3$DATE
FILE_PREFIX4=$OWNER4$DATE
FILE_PREFIX5=$OWNER5$DATE
FILE_PREFIX6=$OWNER6$DATE
FILE_PREFIX7=$OWNER7$DATE

################################# 导出文件名 = 文件名+当前日期.dmp ###############################
DMP_FILE_NAME1=$FILE_PREFIX1$DMP_SUFFIX
DMP_FILE_NAME2=$FILE_PREFIX2$DMP_SUFFIX
DMP_FILE_NAME3=$FILE_PREFIX3$DMP_SUFFIX
DMP_FILE_NAME4=$FILE_PREFIX4$DMP_SUFFIX
DMP_FILE_NAME5=$FILE_PREFIX5$DMP_SUFFIX
DMP_FILE_NAME6=$FILE_PREFIX6$DMP_SUFFIX
DMP_FILE_NAME7=$FILE_PREFIX7$DMP_SUFFIX



################################# 日志文件名 = 文件名+当前日期.log ###############################
LOG_FILE_NAME1=$FILE_PREFIX1$LOG_SUFFIX
LOG_FILE_NAME2=$FILE_PREFIX2$LOG_SUFFIX
LOG_FILE_NAME3=$FILE_PREFIX3$LOG_SUFFIX
LOG_FILE_NAME4=$FILE_PREFIX4$LOG_SUFFIX
LOG_FILE_NAME5=$FILE_PREFIX5$LOG_SUFFIX
LOG_FILE_NAME6=$FILE_PREFIX6$LOG_SUFFIX
LOG_FILE_NAME7=$FILE_PREFIX7$LOG_SUFFIX




################################# zip 文件名称 = 文件名+当前日期 ##############################
ZIP_FILE_NAME1=$FILE_PREFIX1$ZIP_SUFFIX
ZIP_FILE_NAME2=$FILE_PREFIX2$ZIP_SUFFIX
ZIP_FILE_NAME3=$FILE_PREFIX3$ZIP_SUFFIX
ZIP_FILE_NAME4=$FILE_PREFIX4$ZIP_SUFFIX
ZIP_FILE_NAME5=$FILE_PREFIX5$ZIP_SUFFIX
ZIP_FILE_NAME6=$FILE_PREFIX6$ZIP_SUFFIX
ZIP_FILE_NAME7=$FILE_PREFIX7$ZIP_SUFFIX



###########################################  7天前zip文件名称 ######################################################
AGO_DATE_ZIP_FILE_NAME1=$OWNER1$AGO_DATE$ZIP_SUFFIX
AGO_DATE_ZIP_FILE_NAME2=$OWNER2$AGO_DATE$ZIP_SUFFIX
AGO_DATE_ZIP_FILE_NAME3=$OWNER3$AGO_DATE$ZIP_SUFFIX
AGO_DATE_ZIP_FILE_NAME4=$OWNER4$AGO_DATE$ZIP_SUFFIX
AGO_DATE_ZIP_FILE_NAME5=$OWNER5$AGO_DATE$ZIP_SUFFIX
AGO_DATE_ZIP_FILE_NAME6=$OWNER6$AGO_DATE$ZIP_SUFFIX
AGO_DATE_ZIP_FILE_NAME7=$OWNER7$AGO_DATE$ZIP_SUFFIX



########################################### 导出文件 ######################################################
echo "开始导出所有者为 $OWNER1 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME1  log=$LOG_PATH/$LOG_FILE_NAME1 owner=$OWNER1  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y

echo "开始导出所有者为 $OWNER2 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME2  log=$LOG_PATH/$LOG_FILE_NAME2 owner=$OWNER2  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y

echo "开始导出所有者为 $OWNER3 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME3  log=$LOG_PATH/$LOG_FILE_NAME3 owner=$OWNER3  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y

echo "开始导出所有者为 $OWNER4 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME4  log=$LOG_PATH/$LOG_FILE_NAME4 owner=$OWNER4  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y

echo "开始导出所有者为 $OWNER5 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME5  log=$LOG_PATH/$LOG_FILE_NAME5 owner=$OWNER5  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y

echo "开始导出所有者为 $OWNER6 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME6  log=$LOG_PATH/$LOG_FILE_NAME6 owner=$OWNER6  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y

echo "开始导出所有者为 $OWNER7 的数据"
echo $UNAME/$PASSWD@$SERVER_NAME file=$DMP_PATH/$DMP_FILE_NAME7  log=$LOG_PATH/$LOG_FILE_NAME7 owner=$OWNER7  buffer=$BUFFER_SIZE recordlength=$RECODE_LENGTH direct=y


########################################### 压缩文件 ######################################################
echo "进入导出文件目录"
#cd $DMP_PATH

echo "压缩文件开始"

if [[ -a $DMP_FILE_NAME1 ]]; then
echo "正在压缩 $DMP_FILE_NAME1"
zip -q -r $ZIP_FILE_NAME1 $DMP_FILE_NAME1
echo "文件$DMP_FILE_NAME1压缩完毕"
else
	echo "$DMP_FILE_NAME1不存在"
fi

if [[ -a $DMP_FILE_NAME2 ]]; then
echo "正在压缩 $DMP_FILE_NAME2"
zip -q -r $ZIP_FILE_NAME2 $DMP_FILE_NAME2
echo "文件$DMP_FILE_NAME2压缩完毕"
else
	echo "$DMP_FILE_NAME2不存在"
fi

if [[ -a $DMP_FILE_NAME3 ]]; then
echo "正在压缩 $DMP_FILE_NAME3"
zip -q -r $ZIP_FILE_NAME3 $DMP_FILE_NAME3
echo "文件$DMP_FILE_NAME3压缩完毕"
else
	echo "$DMP_FILE_NAME3不存在"
fi

if [[ -a $DMP_FILE_NAME4 ]]; then
echo "正在压缩 $DMP_FILE_NAME4"
zip -q -r $ZIP_FILE_NAME4 $DMP_FILE_NAME4
echo "文件$DMP_FILE_NAME4压缩完毕"
else
	echo "$DMP_FILE_NAME4不存在"
fi

if [[ -a $DMP_FILE_NAME5 ]]; then
echo "正在压缩 $DMP_FILE_NAME5"
zip -q -r $ZIP_FILE_NAME5 $DMP_FILE_NAME5
echo "文件$DMP_FILE_NAME5压缩完毕"
else
	echo "$DMP_FILE_NAME5不存在"
fi

if [[ -a $DMP_FILE_NAME6 ]]; then
echo "正在压缩 $DMP_FILE_NAME6"
zip -q -r $ZIP_FILE_NAME6 $DMP_FILE_NAME6
echo "文件$DMP_FILE_NAME6压缩完毕"
else
	echo "$DMP_FILE_NAME6不存在"
fi
if [[ -a $DMP_FILE_NAME7 ]]; then
echo "正在压缩 $DMP_FILE_NAME7"
zip -q -r $ZIP_FILE_NAME7 $DMP_FILE_NAME7
echo "文件$DMP_FILE_NAME7压缩完毕"
else
	echo "$DMP_FILE_NAME7不存在"
fi


echo "压缩完毕"
################################################压缩完后删除.dmp文件 #######################################

echo "删除 dmp 文件开始"
if [[ -a $DMP_FILE_NAME1 ]]; then
echo "删除$DMP_FILE_NAME1"
	rm -rf $DMP_FILE_NAME1
echo "删除成功"
else
 echo "$DMP_FILE_NAME1文件不存在"
fi

if [[ -a $DMP_FILE_NAME2 ]]; then
echo "删除$DMP_FILE_NAME2"
 rm -rf $DMP_FILE_NAME2
echo "删除成功"
else
 echo "$DMP_FILE_NAME2文件不存在"
fi

if [[ -a $DMP_FILE_NAME3 ]]; then
echo "删除$DMP_FILE_NAME3"
 rm -rf $DMP_FILE_NAME3
echo "删除成功"
else
 echo "$DMP_FILE_NAME3文件不存在"
fi


if [[ -a $DMP_FILE_NAME4 ]]; then
echo "删除$DMP_FILE_NAME4"
 rm -rf $DMP_FILE_NAME4
echo "删除成功"
else 
 echo "$DMP_FILE_NAME4文件不存在"
fi

if [[ -a $DMP_FILE_NAME5 ]]; then
echo "删除$DMP_FILE_NAME5"
 rm -rf $DMP_FILE_NAME5
echo "删除成功"
else 
 echo "$DMP_FILE_NAME5文件不存在"
fi

if [[ -a $DMP_FILE_NAME6 ]]; then
echo "删除$DMP_FILE_NAME6"
 rm -rf $DMP_FILE_NAME6
echo "删除成功"
else
 echo "$DMP_FILE_NAME6文件不存在"
fi

if [[ -a $DMP_FILE_NAME7 ]]; then
echo "删除$DMP_FILE_NAME7"
 rm -rf $DMP_FILE_NAME7
echo "删除成功"
else 
 echo "$DMP_FILE_NAME7文件不存在"
fi



################################### 删除7天前文件.zip 文件 ###################################

echo "开始删除7天前压缩文件"
if [[ -a $AGO_DATE_ZIP_FILE_NAME1 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME1"
rm -rf $AGO_DATE_ZIP_FILE_NAME1
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME1文件不存在"
fi


if [[ -a $AGO_DATE_ZIP_FILE_NAME2 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME2"
rm -rf $AGO_DATE_ZIP_FILE_NAME2
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME2文件不存在"
fi


if [[ -a $AGO_DATE_ZIP_FILE_NAME3 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME3"
rm -rf $AGO_DATE_ZIP_FILE_NAME3
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME3文件不存在"
fi


if [[ -a $AGO_DATE_ZIP_FILE_NAME4 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME4"
rm -rf $AGO_DATE_ZIP_FILE_NAME4
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME4文件不存在"
fi


if [[ -a $AGO_DATE_ZIP_FILE_NAME5 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME5"
rm -rf $AGO_DATE_ZIP_FILE_NAME5
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME5文件不存在"
fi


if [[ -a $AGO_DATE_ZIP_FILE_NAME6 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME6"
rm -rf $AGO_DATE_ZIP_FILE_NAME6
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME6文件不存在"
fi


if [[ -a $AGO_DATE_ZIP_FILE_NAME7 ]]; then
 echo "开始删除$AGO_DATE_ZIP_FILE_NAME7"
rm -rf $AGO_DATE_ZIP_FILE_NAME7
echo "删除成功"
else 
 echo "$AGO_DATE_ZIP_FILE_NAME7文件不存在"
fi
