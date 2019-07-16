#!/bin/bash
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

#卸载冲突包
rpm -e --nodeps xcb-util-0.3.6-6.el6.x86_64

#安装编程环境
yum -y install pcre-devel openssl-devel gcc+ gcc-c++ make gdb mysql perl-DBD-MySQL mysql-devel python-pip python-devel|| exit 2

#安装php环境
yum -y install php-mbstring php-xml libmemcached php-pecl-memcached php-pecl-memcache php-gd php-mysql php php-fpm || exit 2
yum install -y @base @core @additional-devel @compat-libraries kernel-devel expect net-snmp pcre-devel telnet gcc gcc-4* gcc-gfortran openssl openssl-devel openssl-perl openssl-static openssl098e mysql || exit 2

## disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#禁用sshd DNS反解
sed -i 's/^GSSAPIAuthentication yes$/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

#vim支持中文
cat >> /etc/vimrc <<-EOF
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
EOF
#生效修改
/sbin/sysctl -p
echo lalalala is done!
