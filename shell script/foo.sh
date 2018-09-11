#!/bin/bash

APP_VERSION="1.0"
APP_NAME="tomcat"
INIT_COMMAND="$HOME/tomcat_1/bin/startup.sh"
INIT_ARGS=""
PID_FILE="echo $$ >${APP_NAME}.pid"
LOG_FILE=">>${APP_NAME}.log 2>&1 &"

function usage(){
        echo "需要输入：start|stop|restart"
        echo "	start 启动程序"
        echo "	stop 关闭程序"
        echo "	restart 重启程序"
	exit 1
}

case "$1" in

	start)
		echo "========== ${APP_NAME} will be start !==========="
		## check app process weather exists
		COMMON_COMMAND=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
		#echo "${COMMON_COMMAND}"
		if [ -z ${PID=${COMMON_COMMAND}} ]; then
			#执行启动命令 
			${INIT_COMMAND} ${INIT_ARGS} ${LOG_FILE} ${PID_FILE}
			sleep 2
			PID=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
			echo " ...${APP_NAME} is starting PID= ${PID}"
			echo $!
		
		else
			echo " ...${APP_NAME} is Already started ! PID=${PID}"
		fi
      		;;

	stop)
		echo "========== ${APP_NAME} will be stop !==========="
		## check app process weather exists
		COMMON_COMMAND=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
		if [ -z ${PID=${COMMON_COMMAND}} ]; then
			echo " ...${APP_NAME} is not exist !"
		else
				
			echo " ...${APP_NAME}  is stopping ! pid=${PID}. $(kill -9 ${PID})"
			sleep 3
			COMMON_COMMAND=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
			if [ -z $(PID=${COMMON_COMMAND}) ]; then
				echo " ...${APP_NAME} is already stopped !"
			else
				echo " ...${APP_NAME}  is stopping  again ! pid=${PID},$(kill -9 ${PID})"
			fi	
		fi
        	;;

	restart)
        	./$0 stop
        	sleep 2
        	./$0 start
		;;

	*)
        	## usage
		usage
        	;;
esac
exit 0

