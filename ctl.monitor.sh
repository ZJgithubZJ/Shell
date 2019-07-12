#!/bin/bash

SCRIPT_PATH=`pwd`
MONITOR_DAEMON="monitor_process_sdo.sh"

start()
{
PRC_MONITOR=`ps -ef | grep "$MONITOR_DAEMON" | grep -v "grep"`
if [ -z "$PRC_MONITOR" ]
then
	chmod +x $SCRIPT_PATH/$MONITOR_DAEMON
	sh $SCRIPT_PATH/$MONITOR_DAEMON > /dev/null 2>&1 &
	echo "$MONITOR_DAEMON started"
else
	echo "$MONITOR_DAEMON is already running"
fi
}

stop()
{
PRC_MONITOR=`ps -ef | grep "$MONITOR_DAEMON" | grep -v "grep"`
if [ -z "$PRC_MONITOR" ]
then
	echo "$MONITOR_DAEMON is not running"
else
	killall -9 $MONITOR_DAEMON 
	echo  "$MONITOR_DAEMON stop"
fi
}

case $1 in 
start)
	start
	;;
stop)
	stop
	;;
restart)
	stop
	sleep 1
	start
	;;
status)
	A=`ps -ef | grep "$MONITOR_DAEMON" | grep -v grep | wc -l`
	if [ $A == 0 ]
	then
		echo "$MONITOR_DAEMON is stoped"
	else
		echo ps -ef | grep $MONITOR_DAEMON
	fi
	;;
help)
	echo "Usage: $0 {start|stop|restart|status|help}"
	exit 1
	;;
*)
	echo "Usage: $0 {start|stop|restart|status|help}"
	exit 2
esac
