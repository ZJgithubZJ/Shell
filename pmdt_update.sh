#!/bin/bash
#拍卖及魔力变更新脚本,根据提示在脚后面添加适当参数。
date=`date +"%Y%m%d"`
if [ $# -ne 2 ];then
    echo -e "\033[1;31mPlease use databases:\ndmz_act_basic_2015\ndmz_act_basic_2016\ndmz_act_basic_2017\ndmz_act_basic_2018\nAnd tables:\nxchft_prize_config\nwzpiku_prize_config\nsqmlb_prize_config\npmdt_prize_config\nhgshl_prize_config\nczxfs_prize_config \033[0m"
    exit 1
fi
echo ====================拉取====================
mysqldump -udmz -pdmz8PHtvbRZoEZdS -h $1 $2 > pmdt.sql
if [ $? -ne 0 ];then
	echo 'something error here'
	exit 2
else 
	echo "拉取 OK"
fi

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

echo ===================同步=====================
if [ $2 == 'pmdt_prize_config' ];then
	rsync -avz --password-file='/app/rsync/rsyncd.pass' /opt/wwwroot/32/xx5/act.xx5.com/wwwroot/2017/pmdt/pic/ agent@10.105.70.21::xx5/act.xx5.com/wwwroot/2017/pmdt/pic/ || exit 1
elif [ $2 == 'sqmlb_prize_config' ];then
	rsync -avz --password-file='/app/rsync/rsyncd.pass' /opt/wwwroot/32/xx5/act.xx5.com/wwwroot/2017/sqmlb/pic/ agent@10.105.70.21::xx5/act.xx5.com/wwwroot/2017/sqmlb/pic/ || exit 1
else
	echo 'worng para!'
	exit 2
fi
echo 'lalala is done!'
