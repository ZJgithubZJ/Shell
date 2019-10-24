#!/bin/bash
servers=(
	"node1"
	"QUIT"
)

PS3="选择你要进的服务器?"
select server in "${servers[@]}"; do
        if [[ -z $server ]]; then
                echo '请选择菜单里的数字'
                continue
        fi
	if [[ $server == 'QUIT' ]]; then
		echo 'quit'
		exit 0
	fi
	echo 'connecting...'
	ip=`cat lala | grep $server | awk '{print $2}'`
	ssh $ip
done
