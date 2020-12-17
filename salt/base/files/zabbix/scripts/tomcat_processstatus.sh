#!/bin/bash
javamem(){
 ps aux|grep "java"|grep -v "grep"|grep -v "processstatus.sh"|awk '{sum+=$6}; END{print sum}'
}
javacpu(){
 ps aux|grep "java"|grep -v "grep"|grep -v "processstatus.sh"|awk '{sum+=$3}; END{print sum}'
}
javanum(){
 ps aux|grep "java"|grep -v "grep"|grep -v "processstatus.sh"| wc -l
}
httpdmem(){
 ps aux|grep "httpd"|grep -v "grep"|grep -v "processstatus.sh"|awk '{sum+=$6}; END{print sum}'
}
httpdcpu(){
 ps aux|grep "httpd"|grep -v "grep"|grep -v "processstatus.sh"|awk '{sum+=$3}; END{print sum}'
}
httpdnum(){
 ps aux|grep "httpd"|grep -v "grep"|grep -v "processstatus.sh"| wc -l
}
case "$1" in
javamem)
javamem
;;
javacpu)
javacpu
;;
javanum)
javanum
;;
httpdmem)
httpdmem
;;
httpdcpu)
httpdcpu
;;
httpdnum)
httpdnum
;;
*)
echo "Usage: $0 {javamem|javacpu|javanum|httpdmem|httpdcpu|httpdnum|}"
esac
