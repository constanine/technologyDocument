#!/bin/bash
#java应用所在的地址
export DIR_APP_SERVER=xxx
#心跳监听的日志
export DIR_ALIVELOG_FOLDER=xxx
#java应用的应用名
export JAVA_APP_NAME=xxx
#java应用抓获痕迹
export JAVA_APP_TRACE=xxx
export JAVA_APP_START_SHELL=xxx

DATESTAMP=$(date +%Y%m%d)
mkdir -pv "${DIR_ALIVELOG_FOLDER}/${DATESTAMP}"
SERVER_ALIVE_LOG="${DIR_ALIVELOG_FOLDER}/${DATESTAMP}/${JAVA_APP_NAME}.log"
touch "${SERVER_ALIVE_LOG}"
echo "${SERVER_ALIVE_LOG}"
ls -als "${DIR_ALIVELOG_FOLDER}/${DATESTAMP}"
ps -ef | grep java | grep "${JAVA_APP_TRACE}.jar"
if [ $?  -ne 0 ];
then
	cd ${DIR_APP_SERVER}
	./${JAVA_APP_START_SHELL}
else
    echo "`date` erp-server is alive! " >> ${SERVER_ALIVE_LOG}
fi


