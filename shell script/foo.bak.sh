#!/bin/bash

APP_VERSION="1.0"
APP_NAME="ngqualitymdl-core-1.0.0-SNAPSHOT.jar"
RUN_COMMAND="nohup java -jar $PWD/ngqualitymdl-core-1.0.0-SNAPSHOT.jar"
RUN_ARGS=""
PID_FILE="echo $$ >${APP_NAME}.pid"
#LOG_insert=`>`
#LOG_FILE=">${APP_NAME}.log 2>&1 &"

function usage(){
        echo "需要输入：start|stop|restart|status"
        echo "	start 启动程序"
        echo "	stop 关闭程序"
        echo "	restart 重启程序"
	echo "  status 进程状态"
	exit 1
}

case "$1" in

	start)
		echo "========== ${APP_NAME} will be started !==========="
		## check app process weather exists
		COMMON_COMMAND=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
		#echo "${COMMON_COMMAND}"
		if [ -z ${PID=${COMMON_COMMAND}} ]; then
			#执行启动命令 
			$(${RUN_COMMAND} $RUN_ARGS >>${APP_NAME}.log 2>&1 & echo $! >${APP_NAME}.pid)
			#${RUN_COMMAND} ${RUN_ARGS} ${LOG_FILE} ${PID_FILE}
			#$(${RUN_COMMAND} ${RUN_ARGS} ${LOG_FILE} ${PID_FILE})
			sleep 2
			PID=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
			echo " ...${APP_NAME} is running PID= ${PID}"
		
		else
			echo " ...${APP_NAME} is already running PID= ${PID}"
		fi
      		;;

	stop)
		echo "########## ${APP_NAME} will be stopped !###########"
		## check app process weather exists
		COMMON_COMMAND=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
		if [ -z ${PID=${COMMON_COMMAND}} ]; then
			echo " ...${APP_NAME} is not exist !"
		else
				
			echo " ...${APP_NAME} is being closed ! pid=${PID}. $(kill -9 ${PID})"
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
        	#./$0 stop
        	sh $0 stop
        	sleep 2
        	sh $0 start
        	#./$0 start
		;;
	status)
		COMMON_COMMAND=$(ps aux | grep  ${APP_NAME}| grep $USER | grep -v grep | awk '{print $2}')
		if [ -z ${PID=${COMMON_COMMAND}} ]; then
			echo "**** ${APP_NAME} is not running !  **** " 	
		else
			echo "**** ${APP_NAME} is running ! PID= ${PID} *****"
		fi		
		;;
	*)
        	## usage
		usage
        	;;
esac
exit 0

