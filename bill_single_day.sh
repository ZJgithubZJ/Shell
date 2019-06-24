#!/bin/sh

day=$1			#格式为2019_05_01
bill_day=`echo $day | tr '_' ' ' | sed 's/[[:space:]]//g'`
#echo $day 
#echo $bill_day
for bill in `cat tables`
do
	table=${bill/-/_}
	for bill_name in `find /app/sdo/server/bill/ -name "${bill}-bill_$day*"`
	do
		mysql --default-character-set=utf8 --local-infile=1 -h -u -p -e "load data local infile '$bill_name' ignore into table sdo_bill_app001_$bill_day.$table  fields  terminated by ',';"
		#echo $bill_name
	done
done
