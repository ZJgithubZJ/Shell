#!/bin/bash
RATE()
{
	rate=`df -h | grep vdb1 | awk '{print int($5)}'`
	#echo $rate
	if [ "${rate}" -ge 90 ];then
		echo "舞动青春-android-ls: Disk utilization is bigger than 40%, now is $rate" | mail -s 磁盘占用报警 zhangjian@xnhd.com
		echo "舞动青春-android-ls: Disk utilization is bigger than 40%, now is $rate" | mail -s 磁盘占用报警 wanghb@xnhd.com
		#./aldisk.sh $rate > /dev/null 2>&1
	fi
}

while true
do
	RATE
	sleep 60
done
