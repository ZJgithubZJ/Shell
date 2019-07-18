#!/bin/bash
user=""
pwd=""
ip=""
#cmd="select count(*) from sdo_statistic.version where Version='2016120701'"
#cnt=$(mysql -u$user -p$pwd -h$ip -e "${cmd}")
#A=`echo $cnt | awk '{print $2}'`
#echo $A
for file_name in `ls /app/sdo/server/update/*`
do
	S_name=`echo ${file_name##*/}`
    Q_name=`echo ${S_name%%.*}`
    cmd="select count(*) from sdo_statistic.version where Version='${Q_name}'"
    check_version=$(mysql -u$user -p$pwd -h$ip -e "${cmd}")                                    #"${cmd}"这里要格外注意一下，外面双引号，里面是$加{}
    echo $check_version | awk '{print $2}' >> l                                                #该出会跟输出的内容不同而不同，随机应变。
done
