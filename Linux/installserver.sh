#!/bin/bash
yum install -y httpd httpd-devel
/etc/init.d/httpd start
yum install -y mysql mysql-server mysql-devel
/etc/init.d/mysqld start
yum install -y php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml
/etc/init.d/httpd restart
touch /var/www/html/phpinfo.php && echo '<?php phpinfo(); ?>' >> /var/www/html/phpinfo.php
echo "[Webmin]
name=Webmin Distribution Neutral
#baseurl=http://download.webmin.com/download/yum
mirrorlist=http://download.webmin.com/download/yum/mirrorlist
enabled=1" >> /etc/yum.repos.d/webmin.repo
wget http://www.webmin.com/jcameron-key.asc
rpm --import jcameron-key.asc
yum install webmin -y
restorecon -r /var/www/html