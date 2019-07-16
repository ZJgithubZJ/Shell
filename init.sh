#!/bin/bash
### check the OS version ###
VER=`cat /etc/issue |grep release |awk -F "release" '{print substr($2,2,1)}'`
if [ $VER != 6 ];then
echo "this script is only for CentOS 6 "
exit 1
fi
mkdir -p /app/sdo/nginx/p-wwwroot
mkdir -p /app/sdo/nginx/wwwroot
mkdir -p /app/sdo/script 

#数据盘分区(2个空行 代表 2个回车, 切不可删除)
#fdisk /dev/vdb << INPUT_CMD
#n
#p
#1

#+90G
#w
#INPUT_CMD

#数据盘格式化，此处还有个vdb2没有格式化，大小20G，用途待定。
mkfs.ext3 /dev/vdb1 || exit 1

#手动挂载数据盘
mkdir /app || exit 1
mount /dev/vdb1 /app || exit 1
mount -t tmpfs -o size=8G tmpfs /dev/shm

#设置开机自动挂载数据盘
echo '/dev/vdb1 /app ext3 defaults 0 0' >> /etc/fstab
echo 'tmpfs /dev/shm tmpfs defaults,size=8G 0 0' >> /etc/fstab
#创建swap分区
mkdir /usr/local/swap
dd if=/dev/zero of=/usr/local/swap/swap bs=1M count=8192 || exit 2
mkswap  /usr/local/swap/swap
swapon  /usr/local/swap/swap
echo '/home/swap swap swap defaults 0 0' >> /etc/fstab

#修改系统设置
echo "ulimit -f unlimited" >> /etc/profile
echo "export LANG=\"en_US.UTF-8\"" >> /etc/profile

#性能和安全方面的初始化你再整理下：
#core文件加上pid
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
#调节message的最大值
echo "kernel.msgmnb = 65536" >> /etc/sysctl.conf
# 调整message队列的最大值
echo "kernel.msgmax = 65536" >> /etc/sysctl.conf
# 调整共享内存的大小，最大值
echo "kernel.shmmax=68719476736" >> /etc/sysctl.conf
# 可以创建多少个共享内存
echo "kernel.shmall=4294967296" >> /etc/sysctl.conf


##资源限制设置#
cat >>/etc/security/limits.conf <<-EOF
*        soft   core   1024000
*        soft   nproc  65535
*        hard   nproc  65535
*        soft   nofile  65535
*        hard   nofile  65535
EOF


#安装监测环境
yum -y install oprofile sysstat iptraf dstat || exit 2
chkconfig irqbalance on
chkconfig network on
chkconfig rsyslog on
chkconfig crond on
chkconfig sshd on
chkconfig smartd on
chkconfig sysstat on

#安装编程环境
yum -y install pcre-devel openssl-devel gcc+ gcc-c++ make gdb mysql perl-DBD-MySQL mysql-devel python-pip python-devel|| exit 2
#安装php环境
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
php_v=php56w
yum -y install mysql ${php_v} nginx || exit 2
yum -y install ${php_v}-cli ${php_v}-gd ${php_v}-imap ${php_v}-ldap ${php_v}-mysqlnd ${php_v}-odbc ${php_v}-pear ${php_v}-xml ${php_v}-xmlrpc ${php_v}-mbstring ${php_v}-mcrypt ${php_v}-pdo ${php_v}-snmp ${php_v}-soap ${php_v}-tidy ${php_v}-common ${php_v}-devel ${php_v}-fpm ${php_v}-pecl-memcached ${php_v}-opcache || exit 2
#安装nginx环境
yum install -y @base @core @additional-devel @compat-libraries kernel-devel expect net-snmp pcre-devel telnet gcc gcc-4* gcc-gfortran openssl openssl-devel openssl-perl openssl-static openssl098e mysql || exit2

## disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#禁用sshd DNS反解
sed -i 's/^GSSAPIAuthentication yes$/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

#设置history格式
cat >> /etc/profile <<-EOF
HISTFILESIZE=2000
HISTSIZE=2000
HISTTIMEFORMAT="%F %T "
export HISTTIMEFORMAT
EOF

#设置sshd链接限制
cat >> /etc/hosts.allow <<-EOF
sshd:***
sshd:***
sshd:10.203.
EOF
cat >> /etc/hosts.deny <<-EOF
sshd:all
EOF

#vim支持中文并高亮
cat >> /etc/vimrc <<-EOF
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
EOF
#生效修改
/sbin/sysctl -p
echo lalalala is done!
