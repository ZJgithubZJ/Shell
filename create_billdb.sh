#!/bin/bash
ip=''
user=''
passwd=''

if [ $# -ne 1 ];then
	echo -e "\033[1;33mUsage: ./$0 Year \033[0m"
	exit 1
fi

for mon in `seq -f %02g 1 12`
do
	mysql -u${user} -p${passwd} -h${ip} -e "create database dmz_bill_${1}${mon};" || exit 1
	mysql -u${user} -p${passwd} -h${ip} dmz_bill_${1}${mon} < month.sql || exit 1
	for day in `seq -f %02g 1 31`
	do
		mysql -u${user} -p${passwd} -h${ip} -e "create database dmz_bill_${1}${mon}${day};" || exit 1
		mysql -u${user} -p${passwd} -h${ip} dmz_bill_${1}${mon}${day} < day.sql || exit 1
		#echo dmz_bill_$1${mon}${day}
	done
	echo ${1}${mon} done!
done

mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}0229;" || exit 1
mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}0230;" || exit 1	
mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}0231;" || exit 1
mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}0431;" || exit 1
mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}0631;" || exit 1
mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}0931;" || exit 1
mysql -u${user} -p${passwd} -h${ip} -e "drop database dmz_bill_${1}1131;" || exit 1

