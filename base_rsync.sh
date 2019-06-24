#!/bin/bash

rcmd="/app/rsync/rsync -avz --delete -c --progress --password-file=/app/rsync/rsyncd.pass"
aimIP=$1
binDir=$2

fail(){
	set +x
    echo -e "\033[41;37m fail : $1 \033[0m"
    exit 1
}

if [ $# != 2 ]; then
    fail '参数错误'
fi

#chmod +x ../* || fail 'chmod +x script'
#chmod +x ../../bin/* || fail 'chmod +x bin'

set -x

#create agent
\cp ../../$binDir/sdo_tunnel_agent ../../$binDir/sdo_gm_agent || fail 'cp sdo_gm_agent'
\cp ../../$binDir/sdo_tunnel_agent ../../$binDir/sdo_pay_agent || fail 'cp sdo_pay_agent'

#copy to bin
rm -rf ../../bin || fail 'rm bin'
\cp -r ../../$binDir ../../bin || fail 'cp $binDir'

#rsync to aim machine
$rcmd --exclude-from=/app/rsync/exclude_list.txt ../../bin agent@$aimIP::sdoserver/ || fail 'bin'
$rcmd --exclude-from=/app/rsync/exclude_config_list.txt ../../config agent@$aimIP::sdoserver/ || fail 'config'
$rcmd --exclude-from=/app/rsync/exclude_list.txt ../../sql agent@$aimIP::sdoserver/ || fail 'sql'
$rcmd --exclude-from=/app/rsync/exclude_list.txt ../../zone agent@$aimIP::sdoserver/ || fail 'zone'
$rcmd --exclude-from=/app/rsync/exclude_list.txt ../../update agent@$aimIP::sdoserver/ || fail 'update'
$rcmd --exclude-from=/app/rsync/exclude_list.txt ../../script agent@$aimIP::sdoserver/ || fail 'script'
