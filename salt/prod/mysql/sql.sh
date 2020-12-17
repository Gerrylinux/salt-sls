#!/bin/bash
##mysql标准化配置
Mysql_Path=/usr/local/mysql/bin/mysql

        ##安装路径为:/usr/local/mysql/
        ##数据文件路径为:/data/mysql/  安装时已指定
	
	##优化mysql所占内存
        valsize=`free -m|sed -n "2, 1p"|awk '{printf("%0.f\n",$2*0.5/1000)}'|awk '{print $1"G"}'`
        /bin/sed -i "s/innodb_buffer_pool_size=256M/innodb_buffer_pool_size=$valsize/g" /etc/my.cnf


        ##统一配置文件路径
        #/bin/rm -rf /etc/my.cnf
        #/bin/ln -s /usr/local/mysql/etc/my.cnf /etc/my.cnf
        ##socket默认在/temp/mysql.socket
        ##日志配置:默认错误日志配置于/var/log/mysqld.log下。binlog和数据文件位于同一目录下

        ##统一账号密码管理
        ##创建cigdba用户和密码并授权
        dbUser='root'
        dbPassword='59A[Saoth1lu#6]8'
        $Mysql_Path -u$dbUser -e "use mysql; update user set authentication_string=password('$dbPassword') where user='root'"
        # $Mysql_Path -u$dbUser -e "CREATE USER root@'localhost' IDENTIFIED BY '$dbPassword';"
        # $Mysql_Path -u$dbUser -e "grant all on *.* to cigdba@'localhost' with grant option;"
        ##创建备份账号并授权
        $Mysql_Path -u$dbUser -e "CREATE USER dumper@'localhost' IDENTIFIED BY ')j#)=uRig4yJ';"
        $Mysql_Path -u$dbUser -e "GRANT SELECT ON *.* TO dumper@'localhost';"
        $Mysql_Path -u$dbUser -e "GRANT SHOW VIEW ON *.* TO dumper@'localhost';"
        $Mysql_Path -u$dbUser -e "GRANT LOCK TABLES ON *.* TO dumper@'localhost';"
        $Mysql_Path -u$dbUser -e "GRANT LOCK TABLES ON *.* TO dumper@'localhost';"
        $Mysql_Path -u$dbUser -e "GRANT LOCK TABLES ON *.* TO dumper@'localhost';"
        ##修改root密码
        $Mysql_Path -u$dbUser -e "use mysql; delete from user where user='';"
        $Mysql_Path -u$dbUser -e "flush privileges;"
        ##重启mysql
        #/sbin/service mysqld restart
	systemctl restart mysqld
	echo $dbPassword > /opt/mysql_root_pass
