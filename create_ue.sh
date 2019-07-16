#!/bin/bash
read -p "Input Target Year:" Year
for mon in `seq -f %02.0f 01 12`
do
	for day in `seq -f %02.0f 01 31`
	do
		#echo dmz_ue_${Year}${mon}${day}
		mysql -uuser -ppasswd -h127.0.0.1 -e "create database dmz_ue_${Year}${mon}${day};" || exit 1
		mysql -uuser -ppasswd -h127.0.0.1 dmz_ue_${Year}${mon}${day} < ue.sql || exit 1
		echo dmz_ue_${Year}${mon}${day} done!
	done
done

mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}0229;"
mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}0230;"
mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}0231;"
mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}0431;"
mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}0631;"
mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}0931;"
mysql -uuser -ppasswd -h127.0.0.1 -e "drop database dmz_ue_${Year}1131;"

