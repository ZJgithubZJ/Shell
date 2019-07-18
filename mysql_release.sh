#!/bin/bash
read -p "目标库是否需要备份?(Y/N)" answer

empty()
{
mysql -e "show databases" | grep -v mysql | grep -v test | grep -v information_schema | grep -v performance_schema | grep -v Database > base_file
for base in `cat base_file`
do
	#echo ${base}
	mysqldump --single-transaction ${base} --no-data > ${base}.sql
	mysql ${base} < ${base}.sql
	echo ${base} has been emptyed!
done
}

backup()
{
date=`date '+%Y%m%d'`
mysqldump --single-transaction --all-databases >> /home/all_${date}.sql 
echo 'Backup Done!'
}

case ${answer} in 
Y)
	backup
	sleep 1
	empty
	;;
N)
	empty
	;;
*)
	echo 'para error!'
	exit 1
esac
