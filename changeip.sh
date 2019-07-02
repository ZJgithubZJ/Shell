#!/bin/bash
file_list=`find . -type f | grep -v .svn | grep -v xls | grep -v php_script | grep -v sky5 | grep -v .sql | grep -v $0 |grep -v doc| grep -v "dmz_[a-z]*server$"`
newip='10.105.220.96'
for file in ${file_list} 
do
        ip_list=`grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}' $file` #不能加-a选项，会把二进制文件也修改掉的，匹配到的话就直接报错忽略好了。
        if [ -z "${ip_list}" ];then						#因为不是所有find出来的文件中都能匹配到IP，如果没有会返回空格，这是是把没有匹配到IP的文件过滤掉。
                continue
        fi
        echo "${ip_list}"
        for ip in ${ip_list}							#这里需要注意下，当每个文件循环了之后，还需要对某一个文件的多个IP多循环，容易忽视！
        do
                sed -i 's/'${ip}'/'${newip}'/g' $file
        done
done
