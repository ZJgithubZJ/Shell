#!/bin/bash
a=server01    #服务器IP
name=beam.zip   #需要分发的文件
vernum1=(1001 1207 1245)   #即将要更新的区服ID

for i in ${vernum1[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server02    #服务器IP
name=beam.zip   #需要分发的文件
vernum2=(1208 1246)   #即将要更新的区服ID

for i in ${vernum2[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server03    #服务器IP
name=beam.zip   #需要分发的文件
vernum3=(1209 1117 1247)   #即将要更新的区服ID

for i in ${vernum3[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server04    #服务器IP
name=beam.zip   #需要分发的文件
vernum4=(1210 1248)   #即将要更新的区服ID

for i in ${vernum4[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server05    #服务器IP
name=beam.zip   #需要分发的文件
vernum5=(1125 1173 1211 1249)   #即将要更新的区服ID

for i in ${vernum5[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1
a=server06    #服务器IP
name=beam.zip   #需要分发的文件
vernum6=(1212 1250)   #即将要更新的区服ID

for i in ${vernum6[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server07    #服务器IP
name=beam.zip   #需要分发的文件
vernum7=(1213 1165 1251)   #即将要更新的区服ID

for i in ${vernum7[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server08    #服务器IP
name=beam.zip   #需要分发的文件
vernum8=(1214 1033 1252)   #即将要更新的区服ID

for i in ${vernum8[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

sleep 1

a=server09    #服务器IP
name=beam.zip   #需要分发的文件
vernum9=(1215 1253)   #即将要更新的区服ID

for i in ${vernum9[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done
sleep 1

a=server10    #服务器IP
name=beam.zip   #需要分发的文件
vernum10=(1216 1254)   #即将要更新的区服ID

for i in ${vernum10[*]}
do
   salt $a cp.get_file salt://file/$name /app/gameserver_$i/beam/$name
   salt $a cmd.run "cd /app/gameserver_$i/beam/  && rm -rf *.beam &&  unzip $name && rm -rf $name"
    echo "$i ok"
done

