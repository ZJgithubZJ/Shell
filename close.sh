#!/bin/bash
SCRIPT_PATH=`pwd`
#关闭游戏进程
for i in `cat $SCRIPT_PATH/ser_list | grep -v "(^s*#|^s*$)"` 
do
	killall -9 $i
	echo $i has been killed
done

ps -ef | grep sdo_ | grep -v grep | wc -l

	
