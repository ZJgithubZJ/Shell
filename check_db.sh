#!/bin/bash

db_ip=$1
db_user=$2
db_passwd=$3
update_dir='/app/sdo/server/update'

db_cmd="mysql -u${db_user} -p${db_passwd} -h${db_ip} --connect_timeout=10"

#遍历更新脚本
for file_name in `ls ${update_dir}/*`
do 
	short_name=`echo ${file_name##*/}`
	prefix_name=`echo ${short_name%%.*}`

    #检查脚本是否已执行
	check_version="${db_cmd} -e \"select count(1) from sdo_statistic.version where Version='${prefix_name}';\" | tail -n +2"
    check_result=`echo "${check_version}" | sh`
	if [ "${check_result}" == "" ]; then
		echo -e "\033[1;33mFAILED: \033[1;31m${check_version} \033[0m"
		exit 1
	fi
	if [ "${check_result}" == "0" ]; then
		echo -e "\033[1;33mFAILED: \033[1;31m${short_name}\033[1;33m not executed! \033[0m"
		cat ${update_dir}/../bin/version.txt
		exit 1
	fi
done
