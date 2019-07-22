#!/bin/bash
date=`date +"%Y%m%d"`

if [ $# -lt 2 ];then
    echo -e "\033[1;31mPlease input the name of target database and table! \033[0m"
    exit 1
fi

echo ====================拉取======================
mysqldump -uroot -p51..dmz -h $1 $2 > pmdt.sql
if [ $? -eq 0 ];then
    echo ok
else 
    exit 2
fi
sleep 1

echo ====================备份=====================
mysqldump -udmz -pdmz8PHtvbRZoEZd -h --single-transaction dmz_act_basic_2018 $2 > pmdtsql_bak/$2_${date}.sql
if [ $? -eq 0 ];then
    echo OK
else 
    exit 3
fi
sleep 1

echo ====================导入====================
insert=`cat pmdt.sql | grep INSERT`
mysql -udmz -pdmz8PHtvbRZoEZdS -h -e "
use dmz_act_basic_2018;
delete from $2;
set names utf8;
${insert}
quit"
if [ $? -eq 0 ];then
        echo "sql has been updated!"
fi

#这里把sql语句嵌套在shell中，使用delete删除表内容，而不是drop再建，dmz是有delete权限的，应该OK！
