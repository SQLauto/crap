#!/bin/bash
#Update packages first
apt-get --assume-yes update
#Install Apache
apt-get --assume-yes install apache2
service apache2 restart
#Install MysSQL
export DEBIAN_FRONTEND=noninteractive
apt-get -q --assume-yes install mysql-server php5-mysql
service mysql restart
#Install PHP
apt-get --assume-yes install php5 libapache2-mod-php5 php5-mcrypt
service apache2 restart
#Test PHP
touch /var/www/html/info.php && echo '<?php phpinfo(); ?>' >> /var/www/html/info.php
#Install Webmin
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
apt-get --assume-yes update
apt-get --assume-yes install webmin
service webmin restart