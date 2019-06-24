#!/bin/bash

A=`echo "scale=2; 5.5 / 5" | bc`

echo $A

#这里面的scale是用来控制保留几位小数点的，其中计算部分要用双引号引起来。

