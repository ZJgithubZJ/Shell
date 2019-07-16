#!/bin/sh
##install epel source
rpm -ivh epel-release-6-8.noarch.rpm
##Add 51 yum source
yum install -y @base @core @additional-devel @compat-libraries kernel-devel perl-CPAN dstat expect lrzsz net-snmp pcre-devel telnet gcc gcc-4* gcc-c++ gcc-gfortran redhat-lsb-core openssl openssl-devel openssl-perl openssl-static openssl098e mysql
