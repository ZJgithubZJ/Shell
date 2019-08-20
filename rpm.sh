#!/bin/bash
packge_list=`rpm -qa`
for packge in ${packge_list[@]}
do
        result=`rpm -ql ${packge} | grep 'lib4758cca.so'`
        if [ -z ${result} ];then
                continue
        fi
        echo ${packge}
done
