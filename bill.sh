#!/bin/sh

#此脚本配合crontab每分钟执行一次
cd /app/script
day=`date +"%Y%m%d"`
day_hour_ago=`date -d "-1 hours" +"%Y%m%d"`
min=`date +"%M"`
bill_hour=`date +"%Y_%m_%d_%H"`
bill_hour_ago=`date -d "-1 hours" +"%Y_%m_%d_%H"`
for bill in `cat bill.txt`
do
	table=${bill/-/_}
	if [ $min -eq "00" ];then
	for bill_name in `find /app/dmz/ -name "${bill}-bill_${bill_hour_ago}*"`
	do
		#mysql --default-character-set=utf8 --local-infile=1 -h -udod -p -e "load data local infile '$bill_name' ignore into table dmz_bill_$day_hour_ago.$table  fields  terminated by ',';"
		mysql --default-character-set=utf8 --local-infile=1 -h -u -p -e "load data local infile '$bill_name' ignore into table dmz_bill_$day_hour_ago.$table  fields  terminated by ',';"
		#echo $bill $bill_name dmz_bill_$day_hour_ago.$table
	done
	fi

	for bill_name in `find /app/dmz/ -name "${bill}-bill_${bill_hour}*"`
	do
		#mysql --default-character-set=utf8 --local-infile=1 -h -u -p -e "load data local infile '$bill_name' ignore into table dmz_bill_$day.$table  fields  terminated by ',';"
		mysql --default-character-set=utf8 --local-infile=1 -h -u -p -e "load data local infile '$bill_name' ignore into table dmz_bill_$day.$table  fields  terminated by ',';"
		#echo $bill $bill_name dmz_bill_$day.$table
	done
done
