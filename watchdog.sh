#!/bin/bash

shop()
{
	md5_shop=`md5sum /app/nginx/wwwroot/xx5/shop.xx5.com/wwwroot/index.php | awk '{print $1}'`
	if [ "$md5_shop" != "cc6e6244291972bd5807503de21d3535" ];then
		rm -rf /app/nginx/wwwroot/xx5/shop.xx5.com/wwwroot/*.php
		cp -rf /bak/index_shop.php /app/nginx/wwwroot/xx5/shop.xx5.com/wwwroot/index.php
		echo 'Shop has been hit and resolved' | mail -s hacker-shop zhangjian@xnhd.com
	fi
}

pay()
{
	md5_pay=`md5sum /app/nginx/wwwroot/xx5/pay.xx5.com/wwwroot/index.php | awk '{print $1}'`
	if [ "$md5_pay" != "9c16d2ce559bfd5139e1622d7fd7d409" ];then
		rm -rf /app/nginx/wwwroot/xx5/pay.xx5.com/wwwroot/*.php
		cp -rf /bak/index_pay.php /app/nginx/wwwroot/xx5/pay.xx5.com/wwwroot/index.php
		echo 'Pay has been hit and resolved' | mail -s hacker-pay zhangjian@xnhd.com
	fi	
	if [ -f '/app/nginx/wwwroot/xx5/pay.xx5.com/wwwroot/index.html' ];then
		rm -rf /app/nginx/wwwroot/xx5/pay.xx5.com/wwwroot/index.html
		echo 'Pay has been added a HTML and resolved' | mail -s hacker-pay zhangjian@xnhd.com
	fi
}

www_php()
{
	md5_www_php=`md5sum /app/nginx/wwwroot/xx5/www.xx5.com/wwwroot/index.php | awk '{print $1}'`
	if [ "$md5_www_php" != "d84ba69c28c1539f8c78bb2ff3886834" ];then
		rm -rf /app/nginx/wwwroot/xx5/www.xx5.com/wwwroot/index.php
		cp -rf /bak/index_xx5.php /app/nginx/wwwroot/xx5/www.xx5.com/wwwroot/index.php
		echo 'xx5_php has been hit and resolved' | mail -s hacker-xx5 zhangjian@xnhd.com
	fi
}

www_html()
{
	md5_www_html=`md5sum /app/nginx/wwwroot/xx5/www.xx5.com/wwwroot/index.html | awk '{print $1}'`
	if [ "$md5_www_html" != "65943a28176e8bd2c377d1886b47da29" ];then
		rm -rf /app/nginx/wwwroot/xx5/www.xx5.com/wwwroot/index.html
		cp -rf /bak/index_xx5.html /app/nginx/wwwroot/xx5/www.xx5.com/wwwroot/index.html
		echo 'xx5_html has been hit and resolved' | mail -s hacker-xx5 zhangjian@xnhd.com
	fi
}

passport()
{
	md5_pass_php=`md5sum /app/nginx/wwwroot/xx5/passport.xx5.com/wwwroot/index.php | awk '{print $1}'`
	if [ "$md5_pass_php" != '5a075e455cf243c267b89cd7c60109aa' ]; then
		rm -rf /app/nginx/wwwroot/xx5/passport.xx5.com/wwwroot/index.php
		cp -rf /bak/passport.php /app/nginx/wwwroot/xx5/passport.xx5.com/wwwroot/index.php
		echo 'passport..php has been hit and resolved' | mail -s hacker-xx5 zhangjian@xnhd.com
	fi
}
while true
do
	shop
	sleep 30
	pay
	sleep 30
	www_php
	sleep 30
	www_html
	sleep 30
	passport
done
