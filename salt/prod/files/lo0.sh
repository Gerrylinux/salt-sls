#!/bin/bash

# chkconfig: 2345 55 25
# description: lo0 kaijiziqidong 
SNS_VIP=172.16.250.202
#/etc/rc.d/init.d/functions

start(){
       ifconfig lo:0 $SNS_VIP netmask 255.255.255.255 broadcast $SNS_VIP
       /sbin/route add -host $SNS_VIP dev lo:0
       echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
       echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
       echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
       echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
       sysctl -p >/dev/null 2>&1
       echo "RealServer Start OK"
}

stop(){
       ifconfig lo:0 down
       route del $SNS_VIP >/dev/null 2>&1
       echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
       echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
       echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
       echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
       echo "RealServer Stoped"
}

case "$1" in
start)
	start
       ;;
stop)
	stop
       ;;
restart)
	stop
	start
	;;
*)
       echo "Usage: $0 {start|stop|restart}"
       exit 1
esac
exit 0
