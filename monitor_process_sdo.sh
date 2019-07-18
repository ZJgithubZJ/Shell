#!/bin/bash
script_path='/app/sdo/server/script'
server_list_file='/app/sdo/server/script/ser_list'
server_cfg_path='/app/sdo/server/script/../config'

#报警机制
alarm_rtx()
{
	now_date=`date +"%Y-%m-%d %H:%M:%S"`
	tmp_line=`ls -l ${script_cfg_path}/public_zone.xml`
	ZONE_ID=`echo ${tmp_line##*zone/} | cut -d '/' -f 2`
																							#这里的两段tmp_line都是为了得到ZONE_ID和ZONE_NAME的，因此，可以循环使用。	
	tmp_line=`grep zoneid="\"${ZONE_ID}\"" ${script_cfg_path}/public_zoneinfo.xml`
	ZONE_NAME=`echo ${tmp_line##* desc=} | cut -d '"' -f 2`
	
	echo "${now_date}——${ZONE_NAME} | ${ZONE_ID} | $1 重启！" >> ${script_path}/rtx_msg.tmp
	MSG_CONTEXT=`iconv -f utf8 -t gb2312 rtx_msg.tmp`											#iconv是编码转换指令，把utf8转化为gb2312（中国官方编码）
	rm -rf ${script_path}/rtx_msg.tmp
	
	RECEIVER='11446;12009;12288;'
	curl --connect-timeout 3 "http://116.228.191.195:8080/gsm/rtxAlertNew.php?" -d "user=disco&content=${MSG_CONTEXT}&receiver=${RECEIVER}"			#curl指令用于信息传输和的用法要整理一下
	
	if [ ${ZONE_ID} -ge 50000 -a ${ZONE_ID} -lt 90000 ];then
		HAIWAI_RECEIVER='12425;12599;'
		curl --connect-timeout 3 "http://116.228.191.195:8080/gsm/rtxAlertNew.php?" -d "user=disco&content=${MSG_CONTEXT}&receiver=${HAIWAI_RECEIVER}"
	fi
	
	if [ ${ZONE_ID} -ge 96000 -a ${ZONE_ID} -lt 99000 ];then
		QA_RECEIVER='12373;12451;12380;12500;'
		curl --connect-timeout 3 "http://116.228.191.195:8080/gsm/rtxAlertNew.php?" -d "user=disco&content=${MSG_CONTEXT}&receiver={QA_RECEIVER}"
	fi
}

#监测进程
check_process()
{
	for i in `cat $1 | grep -v "(^s*#|^s*$)"`				#这里的$1是后面调用的时候赋值的，这个方法要学习。
	do
		process=`ps -ef | grep $i | grep -v grep`
		if [ -z ${process} ];then
			#重启！
			cd ${script_path} && chmod +x restart_process.sh && ./restart_process.sh $i
			#记录
			echo "`date +"%Y-%m-%d %H:%M:S%"` [monitor] $i is desd and has been started!" >> ${script_path}/monitor.log
			#报警
			alarm_rtx $i > /dev/null 2>&1
		fi
	done
}

#循环
while true
do	
	sleep 60
	check_process ${server_list_file}
done
