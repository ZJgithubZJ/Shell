#!/bin/bash
db_user='admin'
db_passwd='SDO8r0AsKo0A5'
db_ip='10.66.133.74'
db_filedir='/app/sdo/server/update'
db_cmd="mysql -u$db_user -p$db_passwd -h$db_ip --connect-timeout=10"

for db_file in `ls $db_filedir/*`
do
	short_name=`echo "${db_file##*/}"`             	#这个用法就不强调了
	prefix_name=`echo "${short_name%%.*}"`
	suffix_name=`echo "${short_name##*.}"`
	
	#检查脚本类型
	if [ $suffix_name == 'sql' ];then
		update_cmd="${db_cmd} < ${db_file}"
	elif [ $suffix_name == 'py' ];then
		update_cmd="python $db_file $1"	   			#这里的$1就是上面的db_ip,因为在原脚本中她是作为变量的。
	elif [ $suffix_name == 'sh' ];then
		update_cmd="sh $db_file $1"
	else
		continue
	fi
	
	#检查脚本是否已执行
	check_version="${db_cmd} -e \"select cont(*) from sdo_statistic.version where Version='${prefix_name}';\" | tail -n +2"
	check_result=`echo "${check_version}" | sh` 		#这里echo $check_version | sh 和 echo "${check_version}" | sh 是一样的。
	#此时查看check_result的结果的话，echo "${check_result}" 与 echo $check_result是有区别的，前者是显示正确格式，分行，tail能够正确去除数据，后者是显示在一行，数据不正确，在拉取数据库数据的时候要注意。
	if [ $check_result == "" ];then
		echo -e "\033[1;31mFAILED: \033[1;33m${check_version} \033[0m"
		exit 1
	fi
	if [ $check_result != 0 ];then
		continue
	fi
	
	#记录脚本名称
	version_cmd="${db_cmd} -e \"insert into sdo_statistic.version (version) values('${prefix_name}');\""
	echo "${version_cmd}" | sh						#这里涉及到新用法，若A被赋值为一串动作，后面要执行该动作的话，就用echo "${A}" | sh，若要将结果复制给B，就用B=`echo "${A}" | sh`
	if [ $? -ne 0 ];then
		echo -e "\033[1,33mFAILED: \033[1,31m${version_cmd} \033[0m"
		exit 2
	fi
	
	#执行脚本
	echo "${update_cmd}" | sh
	if [ $? -ne 0 ];then
		echo -e "\033[1,33mFAILED: \033[1,31m${update_cmd} \033[0m"
		exit 3
	fi
done	
