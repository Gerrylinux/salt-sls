#!/bin/bash

/bin/mkdir -p /data/mysql/innodb
/bin/mkdir -p /data/mysql/data
/bin/mkdir -p /data/mysql/logs
/bin/mkdir -p /var/log/mysqld
/bin/mkdir -p /var/run/mysqld
/bin/chown -R mysql.mysql /data/mysql 
/bin/chown -R mysql.mysql /var/log/mysqld
/bin/chown -R mysql.mysql /var/run/mysqld
#/usr/local/mysql/bin/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/mysql/ --defaults-file=/etc/my.cnf --user=mysql
/usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf --user=mysql --initialize-insecure
#/usr/local/mysql/bin/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/data/mysql/ --defaults-file=/etc/my.cnf 

