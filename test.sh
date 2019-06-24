#!/bin/bash
cmd="***"
result=`echo "${cmd}" | sh | grep boot | awk '{if($2<200) print $5}'`
echo "$result"
