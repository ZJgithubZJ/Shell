#!/bin/bash
#清理共享内存
chmod +x rm_shm
./rm_shm > /dev/null

sleep 2

SCRIPT_PATH=`pwd`
BIN_PATH=$SCRIPT_PATH/../bin

start_id=1

for i in `cat $SCRIPT_PATH/ser_list | grep -v "(^s*#|^s*$)"`
do
	cd $BIN_PATH
	C_PRO="./ $i -d >> printf.log"
	echo $start_id $C_PRO
	echo $C_PRO|sh
	let start_id++
	usleep 500000
done

ps -ef | grep sdo_ | grep -v grep | wc -l



