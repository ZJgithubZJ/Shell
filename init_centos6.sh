#!/bin/sh
# version 1.1
# author zhangjian@xnhd.com
# date 2017-12-22

### check the OS version ###
VER=`cat /etc/issue |grep release |awk -F "release" '{print substr($2,2,1)}'`
if [ $VER != 6 ];then
echo "this script is only for CentOS 6 "
exit 1
fi
  
### part 3    kernel optimization ###
##下面是网络性能的调整##
#允许复用在time_wait状态的套接字
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
#启动time_wait的快速循环功能,必须打开
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
#设置所有协议的最大系统发送，接收缓冲,我们设置为8MB,不够再加
echo "net.core.rmem_max = 8388608" >> /etc/sysctl.conf
echo "net.core.wmem_max = 8388608" >> /etc/sysctl.conf
#调节tcp创建套接字时耗费的内存,分别为最小,默认,最大
echo "net.ipv4.tcp_rmem = 4096 87380 8388608" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 87380 8388608" >> /etc/sysctl.conf
#backlog的大小，半开连接(syn)保存在 backlog connections 队列中,增加TCP SYN队列长度使系统可以接受更多的并发连接。
echo "net.ipv4.tcp_max_syn_backlog = 4096" >> /etc/sysctl.conf
#允许本地打开端口的范围，默认32768-61000
echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf
#syn发过去，如果没有响应，重新发送的次数,默认5次
echo "net.ipv4.tcp_syn_retries = 2" >> /etc/sysctl.conf
#如果tcp keepalive打开,tcp connection上多久没有数据到达，会引起keepalive探测发送，默认7200秒
echo "net.ipv4.tcp_keepalive_time = 60" >> /etc/sysctl.conf
#如果tcp keepalive打开,TCP发送keepalive消息的次数,超过该次数没有回应则断开连接，默认9次
echo "net.ipv4.tcp_keepalive_probes = 4" >> /etc/sysctl.conf
#如果tcp keepalive打开,TCP发送keepalive探测的频率,默认75秒
echo "net.ipv4.tcp_keepalive_intvl = 15" >> /etc/sysctl.conf
#如果tcp连接上发生了重传,重传几次失败后断开连接，默认15次
echo "net.ipv4.tcp_retries2 = 5" >> /etc/sysctl.conf
#对于本端断开的socket连接，TCP保持在FIN-WAIT-2状态的时间，默认60秒
echo "net.ipv4.tcp_fin_timeout = 30" >> /etc/sysctl.conf

##下面是安全相关的调整##
#是否接受含有源路由信息的ip包,服务器不当网关就关闭掉，有几个网络接口加几行
echo "net.ipv4.conf.eth0.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
#是否接受ICMP重定向包，0表示拒绝任何ICMP重定向，默认1
echo "net.ipv4.conf.eth0.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
#打开安全重定向功能,只接受来自网关的ICMP重定向
echo "net.ipv4.conf.eth0.secure_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.secure_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.secure_redirects = 1" >> /etc/sysctl.conf
#是否允许发送icmp重定向消息，不做网关的话就别发了吧
echo "net.ipv4.conf.eth0.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
#是否接受ICMP广播，我们不接受
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
#是否忽略所有icmp包，包括ping，我们不忽略，我们还是要ping的
echo "net.ipv4.icmp_echo_ignore_all = 0" >> /etc/sysctl.conf

##下面是对系统性能的调整##
#给core文件的文件名带上pid号
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
#调节message的最大值
echo "kernel.msgmnb = 65536" >> /etc/sysctl.conf
# 调整message队列的最大值
echo "kernel.msgmax = 65536" >> /etc/sysctl.conf
# 调整共享内存的大小，最大值
echo "kernel.shmmax = 68719476736" >> /etc/sysctl.conf
# 可以创建多少个共享内存
echo "kernel.shmall = 4294967296" >> /etc/sysctl.conf

##禁用IPV6##
echo "options ipv6 disable=1" >> /etc/modprobe.d/dist.conf
echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network

## disable postfix IPV6
sed -i 's/inet_protocols = all/inet_protocols = ipv4/' /etc/postfix/main.cf

## disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config


##资源限制设置#
cat >>/etc/security/limits.conf <<-EOF
*        soft   core   1024000
*        soft   nproc  65535
*        hard   nproc  65535
*        soft   nofile  65535
*        hard   nofile  65535
EOF

yum install -y sysstat smartmontools
### part 4 service optimization ###
##关闭不需要的服务#################################################################
chkconfig --list|grep :on|awk '{printf "chkconfig %s off\n",$1}'|awk '{system($0)}'
chkconfig irqbalance on
chkconfig network on
chkconfig rsyslog on
chkconfig crond on
chkconfig sshd on
chkconfig smartd on
chkconfig sysstat on

### part 5 app optimization ###
## tune sshd config ##
#禁用sshd DNS反解
sed -i 's/^GSSAPIAuthentication yes$/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

## tune vim config ##
#开启vim语法高亮
echo "syntax on" >> /root/.vimrc
cat >> /etc/vimrc <<-EOF
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
EOF
