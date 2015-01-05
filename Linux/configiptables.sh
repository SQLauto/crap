#!/bin/bash
iptables -F
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT # PING Inbound REQUIRED
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT # PING Inbound REQUIRED
# iptables -A INPUT -p tcp --dport 20 -j ACCEPT # FTP
# iptables -A INPUT -p tcp --dport 21 -j ACCEPT # FTP
iptables -A INPUT -p tcp --dport 22 -j ACCEPT # SSH REQUIRED
iptables -A INPUT -p tcp --dport 80 -j ACCEPT # HTTP
# iptables -A INPUT -p tcp --dport 161 -j ACCEPT # SNMP REQUIRED
iptables -A INPUT -p tcp --dport 443 -j ACCEPT # HTTPS
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT # MySQL
# iptables -A INPUT -p tcp --dport 8800 -j ACCEPT # Solr
# tables -A INPUT -p tcp -m tcp --dport 5666 -j ACCEPT # NRPE REQUIRED
# tables -A OUTPUT -p tcp -m tcp --dport 5666 -j ACCEPT # NRPE REQUIRED
# tables -A INPUT -p tcp --dport 8080 -j ACCEPT # Jenkins/Java/Tomcat/ColdFusion
# iptables -A INPUT -p tcp --dport 8087 -j ACCEPT # Jenkins/Java/Tomcat/ColdFusion
# iptables -A INPUT -p tcp --dport 8088 -j ACCEPT # Jenkins/Java/Tomcat/ColdFusion
# iptables -A INPUT -p tcp --dport 8089 -j ACCEPT # Jenkins/Java/Tomcat/ColdFusion
# iptables -A INPUT -p tcp --dport 8301 -j ACCEPT # Jenkins/Java/Tomcat/ColdFusion
# iptables -A INPUT -p tcp --dport 8302 -j ACCEPT # Jenkins/Java/Tomcat/ColdFusion
# iptables -A INPUT -p tcp --dport 10000 -j ACCEPT # Webmin
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/service iptables save # save config
iptables -L -v -n