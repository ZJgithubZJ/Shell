#!/bin/sh
date=`date +"%Y-%m-%d"`
dir=/app/mv_bill/$date
mkdir $dir -p
find /app/dmz/*server*/bill/ -name "*.txt" -type f -mtime +6 -exec mv {} $dir/ \;
find /app/dmz/*server*/bill/ -name "*.log" -type f -mtime +6 -exec mv {} $dir/ \;
cd /app/mv_bill/
tar czvf $date.tgz /app/mv_bill/$date
rm -rf /app/mv_bill/$date
