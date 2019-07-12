#!/bin/bash
read -p "Input Target Year:" Year
for mon in `seq -f %02.0f 01 12`
do
	for day in `seq -f %02.0f 01 31`
	do
		#echo dmz_ue_${Year}${mon}${day}
		mysql -uroot -p51..dmz -h10.66.110.112 -e "create database dmz_ue_${Year}${mon}${day};" || exit 1
		mysql -uroot -p51..dmz -h10.66.110.112 dmz_ue_${Year}${mon}${day} < ue.sql || exit 1
		echo dmz_ue_${Year}${mon}${day} done!
	done
done

mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}0229;"
mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}0230;"
mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}0231;"
mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}0431;"
mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}0631;"
mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}0931;"
mysql -uroot -p51..dmz -h10.66.110.112 -e "drop database dmz_ue_${Year}1131;"

