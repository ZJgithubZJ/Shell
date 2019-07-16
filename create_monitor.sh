#!/bin/bash

user=
passwd=
host=
port=3306
if [ $# -eq 1 ];then
    today=$1
else 
    today=`date -d next-day +%Y%m%d`
fi

for db in sdo_monitor
do
    for tb in money online guide
    do
        sql="create table if not exists ${db}.${tb}${today} like ${db}.${tb};"
	#echo ${sql}
	mysql -u${user} -p${passwd} -h${host} -P${port} -e "${sql}"
    done
done
