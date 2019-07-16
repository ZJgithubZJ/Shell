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
##�������������ܵĵ���##
#��������time_wait״̬���׽���
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
#����time_wait�Ŀ���ѭ������,�����
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
#��������Э������ϵͳ���ͣ����ջ���,��������Ϊ8MB,�����ټ�
echo "net.core.rmem_max = 8388608" >> /etc/sysctl.conf
echo "net.core.wmem_max = 8388608" >> /etc/sysctl.conf
#����tcp�����׽���ʱ�ķѵ��ڴ�,�ֱ�Ϊ��С,Ĭ��,���
echo "net.ipv4.tcp_rmem = 4096 87380 8388608" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 4096 87380 8388608" >> /etc/sysctl.conf
#backlog�Ĵ�С���뿪����(syn)������ backlog connections ������,����TCP SYN���г���ʹϵͳ���Խ��ܸ���Ĳ������ӡ�
echo "net.ipv4.tcp_max_syn_backlog = 4096" >> /etc/sysctl.conf
#�����ش򿪶˿ڵķ�Χ��Ĭ��32768-61000
echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf
#syn����ȥ�����û����Ӧ�����·��͵Ĵ���,Ĭ��5��
echo "net.ipv4.tcp_syn_retries = 2" >> /etc/sysctl.conf
#���tcp keepalive��,tcp connection�϶��û�����ݵ��������keepalive̽�ⷢ�ͣ�Ĭ��7200��
echo "net.ipv4.tcp_keepalive_time = 60" >> /etc/sysctl.conf
#���tcp keepalive��,TCP����keepalive��Ϣ�Ĵ���,�����ô���û�л�Ӧ��Ͽ����ӣ�Ĭ��9��
echo "net.ipv4.tcp_keepalive_probes = 4" >> /etc/sysctl.conf
#���tcp keepalive��,TCP����keepalive̽���Ƶ��,Ĭ��75��
echo "net.ipv4.tcp_keepalive_intvl = 15" >> /etc/sysctl.conf
#���tcp�����Ϸ������ش�,�ش�����ʧ�ܺ�Ͽ����ӣ�Ĭ��15��
echo "net.ipv4.tcp_retries2 = 5" >> /etc/sysctl.conf
#���ڱ��˶Ͽ���socket���ӣ�TCP������FIN-WAIT-2״̬��ʱ�䣬Ĭ��60��
echo "net.ipv4.tcp_fin_timeout = 30" >> /etc/sysctl.conf

##�����ǰ�ȫ��صĵ���##
#�Ƿ���ܺ���Դ·����Ϣ��ip��,�������������ؾ͹رյ����м�������ӿڼӼ���
echo "net.ipv4.conf.eth0.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
#�Ƿ����ICMP�ض������0��ʾ�ܾ��κ�ICMP�ض���Ĭ��1
echo "net.ipv4.conf.eth0.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
#�򿪰�ȫ�ض�����,ֻ�����������ص�ICMP�ض���
echo "net.ipv4.conf.eth0.secure_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.secure_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.secure_redirects = 1" >> /etc/sysctl.conf
#�Ƿ�������icmp�ض�����Ϣ���������صĻ��ͱ��˰�
echo "net.ipv4.conf.eth0.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.lo.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
#�Ƿ����ICMP�㲥�����ǲ�����
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
#�Ƿ��������icmp��������ping�����ǲ����ԣ����ǻ���Ҫping��
echo "net.ipv4.icmp_echo_ignore_all = 0" >> /etc/sysctl.conf

##�����Ƕ�ϵͳ���ܵĵ���##
#��core�ļ����ļ�������pid��
echo "kernel.core_uses_pid = 1" >> /etc/sysctl.conf
#����message�����ֵ
echo "kernel.msgmnb = 65536" >> /etc/sysctl.conf
# ����message���е����ֵ
echo "kernel.msgmax = 65536" >> /etc/sysctl.conf
# ���������ڴ�Ĵ�С�����ֵ
echo "kernel.shmmax = 68719476736" >> /etc/sysctl.conf
# ���Դ������ٸ������ڴ�
echo "kernel.shmall = 4294967296" >> /etc/sysctl.conf

##����IPV6##
echo "options ipv6 disable=1" >> /etc/modprobe.d/dist.conf
echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network

## disable postfix IPV6
sed -i 's/inet_protocols = all/inet_protocols = ipv4/' /etc/postfix/main.cf

## disable selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config


##��Դ��������#
cat >>/etc/security/limits.conf <<-EOF
*        soft   core   1024000
*        soft   nproc  65535
*        hard   nproc  65535
*        soft   nofile  65535
*        hard   nofile  65535
EOF

yum install -y sysstat smartmontools
### part 4 service optimization ###
##�رղ���Ҫ�ķ���#################################################################
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
#����sshd DNS����
sed -i 's/^GSSAPIAuthentication yes$/GSSAPIAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

## tune vim config ##
#����vim�﷨����
echo "syntax on" >> /root/.vimrc
cat >> /etc/vimrc <<-EOF
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
EOF
