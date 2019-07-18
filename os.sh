#!/bin/bash
if [ $# -lt 1 ]; then
	echo error para
	exit
fi

NAME=$1
LINE=`cat .zone_op/serverlist | grep $1 | grep -v '^#'`
IP=`echo $LINE | awk '{print $2}'`
if [ -z $IP ]; then
	echo error para
	exit
fi

echo $LINE
ssh root@$IP
