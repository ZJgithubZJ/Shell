#!/bin/bash

db_ip=$1
db_user=$2
db_passwd=$3
update_dir='/app/sdo/server/sql/online'

db_cmd="mysql -u${db_user} -p${db_passwd} -h${db_ip} --connect_timeout=10"

#遍历更新脚本
for file_name in `ls ${update_dir}/*`
do 
	short_name=`echo ${file_name##*/}`
	prefix_name=`echo ${short_name%%.*}`
	suffix_name=`echo ${short_name##*.}`

    #检查脚本类型
	if [ "${suffix_name}" == "sql" ]; then
		update_cmd="${db_cmd} < ${file_name}"
	elif [ "${suffix_name}" == "py" ]; then
		update_cmd="python ${file_name} $1"
	elif [ "${suffix_name}" == "sh" ]; then
		update_cmd="sh ${file_name} $1"
    else
        continue
	fi

    #检查脚本是否已执行
	check_version="${db_cmd} -e \"select count(1) from sdo_statistic.version where Version='${prefix_name}';\" | tail -n +2"
    check_result=`echo "${check_version}" | sh`
	if [ "${check_result}" == "" ]; then
		echo -e "\033[1;33mFAILED: \033[1;31m${check_version} \033[0m"
		exit 1
	fi
	if [ "${check_result}" != "0" ]; then
		continue
	fi

    #记录脚本名字
    version_cmd="${db_cmd} -e \"insert into sdo_statistic.version (Version) values('${prefix_name}');\""
    echo "${version_cmd}" | sh
    if [ $? -ne 0 ]; then
		echo -e "\033[1;33mFAILED: \033[1;31m${version_cmd} \033[0m"
        exit 2
    fi

    #执行脚本
    echo "${update_cmd}" | sh
    if [ $? -ne 0 ]; then
		echo -e "\033[1;33mFAILED: \033[1;31m${update_cmd} \033[0m"
        exit 3
    fi
	echo -e "\033[1;32m${update_cmd} \033[0m"
done
