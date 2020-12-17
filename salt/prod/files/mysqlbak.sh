{% from "mysql/map.jinja" import mysql with context -%}
#!/bin/bash
IP=`/sbin/ifconfig | grep inet | /bin/awk -F':' '/Bcast/{print $2}'| awk  -F'.' '{if($3=="250"||$3=="192"||$3=="248"||$3=="224"||$3=="208"){print $0}}'|cut -d' ' -f 1`
echo '=======================================================' >>/data/backup/sync/db/mysqlbklog.txt
echo `date` >> /data/mysqlbak/mysqlbklog.txt
echo "begin backup......." >> /data/backup/sync/db/mysqlbklog.txt
time=$(date '+%Y%m%d' )
Mysqldump={{ mysql.mysql_bin }}/mysqldump
DB_LIST=$(echo "show databases;" | {{ mysql.mysql_bin }}/mysql -u{{ mysql.mysql_dumper_user }}  -p'{{ mysql.mysql_dumper_passwd }}')
for db in ${DB_LIST}
do
  if [ $db != "Database" ] && [ $db != "mysql" ] &&
      [ $db != "phpmyadmin" ] && [ $db != "information_schema" ] &&
      [ $db != "performance_schema" ]; then
    echo "  backup "$db
   $Mysqldump -u{{ mysql.mysql_dumper_user }}  -p'{{ mysql.mysql_dumper_passwd }}' $db>/data/backup/sync/db/$db.sql 
  # $ -u${DB_USER} -p${DB_PASSWORD} $db > mysql/$db.sql
  fi
done
cd /data/backup/sync/db/
tar -zcvf db_$IP_$time.tar.gz /data/backup/sync/db/*.sql
rm -rf /data/backup/sync/db/*.sql
echo `date` >> /data/backup/sync/db/mysqlbklog.txt
echo "backup sucess!!!"  >> /data/backup/sync/db/mysqlbklog.txt
find /data/backup/sync/db/  -type f -mtime +7 -exec rm {} \;
/bin/bash /data/rsyncbackup/backup.sh 
