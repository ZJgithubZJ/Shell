#!/bin/sh
cd /app/nginx/conf/
BAKDATE=`date +%Y%m%d`
OP=$1
case $OP in
newid) 
##CHANGE nginx.conf TO NEWID
NEWID=$2
/bin/cp nginx.conf nginx.conf.bak.$BAKDATE
sed -i 's/#url#rewrite/rewrite/' nginx.conf
sed -i "s/id=51981/id=$NEWID/" nginx.conf
cat nginx.conf |grep "id=$NEWID"
/app/nginx/sbin/nginx -t 
;;
restore) 
##RESTORE nginx.conf FROM BAK
/bin/cp -f nginx.conf.bak.$BAKDATE nginx.conf
cat nginx.conf |grep "#url#rewrite"
;;
reload)
##RELOAD nginx.conf
/app/nginx/sbin/nginx -s reload
;;
*) echo "Usage: `basename $0` {newid id|restore|reload}"
exit
;;
esac
