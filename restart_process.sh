#!/bin/bash
SCRIPT_PATH=`pwd`
if [ $# -lt 1 ]; then
	echo -e "\n\033[1;35mplease input target server! \n\033[0m"
	exit
fi
#关闭进程
C_PRO=`killall -9 $1`
echo "$C_PRO"|sh

#等待关闭完成
SDO_NUM=`ps -ef | grep $1 | grep -v grep | wc -l`
while [ 0 -ne $SDO_NUM ]
do
	sleep 1
	SDO_NUM=`ps -ef | grep $1 | grep -v grep | wc -l`
done

ps -ef | grep $1 | grep -v grep | wc -l

#清理共享内存
./rm_shm

BIN_PATH=$SCRIPT_PATH/../bin/
cd $BIN_PATH
chmod +x sdo_\*

#启动进程
echo > print.log
A="./$1 -d >> print.log"
echo $A|sh

sleep 1
ps -ef | grep $1 
