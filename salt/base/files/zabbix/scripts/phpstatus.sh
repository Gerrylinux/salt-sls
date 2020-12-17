#!/bin/bash


#monitor php-fpm status from zabbix
#lincense:GPL
#mail:admin@huxianglin.cn
#date:2015.04.15


source /etc/bashrc >/dev/null 2>&1
source /etc/profile >/dev/null 2>&1


LOG=/usr/local/zabbix/scripts/php_status.log
curl -s http://localhost:8081/status >$LOG


pool(){
 awk '/pool/ {print $NF}' $LOG
}


process_manager(){
 awk '/process manager/ {print $NF}' $LOG
}


start_since(){
 awk '/start since:/ {print $NF}' $LOG
}


accepted_conn(){
        awk '/accepted conn:/ {print $NF}' $LOG
}
listen_queue(){
        awk '/^(listen queue:)/ {print $NF}' $LOG
}


max_listen_queue(){
        awk '/max listen queue:/ {print $NF}' $LOG
}


listen_queue_len(){
        awk '/listen queue len:/ {print $NF}' $LOG
}


idle_processes(){
        awk '/idle processes:/ {print $NF}' $LOG
}


active_processes(){
        awk '/^(active processes:)/ {print $NF}' $LOG
}


total_processes(){
        awk '/total processes:/ {print $NF}' $LOG
}


max_active_processes(){
        awk '/max active processes:/ {print $NF}' $LOG
}


max_children_reached(){
        awk '/max children reached:/ {print $NF}' $LOG
}
case "$1" in
pool)
 pool
 ;;
process_manager)
 process_manager
 ;;
start_since)
 start_since
 ;;
accepted_conn)
 accepted_conn
 ;;
listen_queue)
 listen_queue
 ;;
max_listen_queue)
 max_listen_queue
 ;;
listen_queue_len)
 listen_queue_len
 ;;
idle_processes)
 idle_processes
 ;;
active_processes)
 active_processes
 ;;
total_processes)
 total_processes
 ;;
max_active_processes)
 max_active_processes
 ;;
max_children_reached)
 max_children_reached
 ;;
*)
echo "Usage: $0 {pool|process_manager|start_since|accepted_conn|listen_queue|max_listen_queue|listen_queue_len|idle_processes|active_processes|total_processes|max_active_processes|max_children_reached}"
esac
