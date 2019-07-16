 #/use/bin/bash
db_list=('config' 'account' 'player' 'item' 'randName' 'wedding' 'register' \
'game' 'statistic' 'chat' 'guild'  'actData' 'smallgame' \
'relation' 'task')
db_host=''
db_user=''
db_passwd=''
sql_file_dir='../sql/sdo_db/'
#这个脚本有点特殊，函数当中用到if判断，并且后面也没有使用到case语句，用for循环加if判断确定变量的不同值，统一调用到前面的函数中，实现不同库名的差异备份，学习一下这个模板，自己再写一下。
dump_db()
{
        dbname=$1
        needdata=$2
        suffix=''

        if [ $# == 3 ]; then
                suffix="_$3"
        fi

        #仅导出表结构
        if [ ${needdata} -eq 0 ]; then
                sql="mysqldump -u${db_user} -p${db_passwd} -h${db_host} --skip-add-locks --skip-dump-date --opt -d sdo_${dbname} > ${sql_file_dir}sdo_${dbname}.sql"
        fi

        #导出表结构、数据
        if [ ${needdata} -eq 1 ]; then
                sql="mysqldump -u${db_user} -p${db_passwd} -h${db_host} --skip-add-locks --skip-dump-date --skip-extended-insert --order-by-primary sdo_${dbname}${suffix} > ${sql_file_dir}sdo_${dbname}.sql"
        fi

        #导出表结构、数据、时间戳
        if [ ${needdata} -eq 2 ]; then
                sql="mysqldump -u${db_user} -p${db_passwd} -h${db_host} --skip-add-locks --skip-extended-insert --order-by-primary sdo_${dbname}${suffix} > ${sql_file_dir}sdo_${dbname}.sql"
        fi

        echo ${sql}
        echo ${sql} | sh
}

for db in ${db_list[@]}
do
        needdata=0

        if [ ${db} = 'randName' ]; then
                needdata=1
        elif [ ${db} = 'config' ]; then
                needdata=2
        fi

        dump_db ${db} ${needdata} $1
        if [ $? != 0 ]; then
                echo "dump ${db} error!"
                exit 1
        fi
done

cd ${sql_file_dir} && sed -i 's/AUTO_INCREMENT=[0-9]*//g' * && svn commit *.sql -m 'db'
