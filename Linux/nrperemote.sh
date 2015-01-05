#!/bin/bash
cd /tmp
wget http://mirror-fpt-telecom.fpt.net/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum install -y nrpe nagios-common nagios-plugins nagios-plugins-nrpe nagios-plugins-{disk,dns,users,load,procs,nrpe}
/usr/lib64/nagios/plugins/check_nrpe -H localhost