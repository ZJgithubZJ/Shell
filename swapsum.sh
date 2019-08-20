#!/bin/sh
for PID in `ls -l /proc |grep ^d |awk '{print $9}' |grep -v [^0-9]`
do
    grep -q "Swap" /proc/$PID/smaps 2>/dev/null
    if [ $? -eq 0 ];then
        COUNT=$(grep Swap /proc/$PID/smaps |wc -l)
        if [ $COUNT -gt 0 ];then
            swap=$(grep Swap /proc/$PID/smaps | gawk '{sum+=$2;} END{print sum}')
            echo -e "PID ${PID}\t SWAPSUM ${swap}"
        fi
     fi
done
