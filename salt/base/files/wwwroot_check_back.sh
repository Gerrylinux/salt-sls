#!/bin/bash
. /root/.bash_profile
IP=`/sbin/ifconfig | grep inet | /bin/awk -F':' '/Bcast/{print $2}'| awk  -F'.' '{if($3=="250"||$3=="192"||$3=="248"||$3=="224"){print $0}}'|cut -d' ' -f 1`
############微信报警##################
CropID=wx0facad1655ce9e06
Secret=6A6kciVGFJQOoGExWomstFHD7Yb-6jm9C6aeRR4-dPQ
GURL="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$CropID&corpsecret=$Secret"
Gtoken=$(/usr/bin/curl -s -G $GURL | awk -F\" '{print $10}')
PURL="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$Gtoken"
###########修改动态报警接收人，到backup.cig.com.cn对应主机下修改backup.html。目前是亦庄备份机 172.16.248.197。
UserID=`curl -s http://backup.cig.com.cn:8000/backup.html`

function body() {
        local int AppID=7
#        local UserID=$1
        local PartyID=2
#       local Msg=$(echo "$@" | cut -d" " -f3-)

        printf '{\n'
        printf '\t"touser": "'"$Users"\"",\n"
        printf '\t"toparty": "'"$PartyID"\"",\n"
        printf '\t"msgtype": "text",\n'
        printf '\t"agentid": "'" $AppID "\"",\n"
        printf '\t"text": {\n'
        printf '\t\t"content": "'"【wwwroot挂载报警】\n$Msg"\""\n"
        printf '\t},\n'
        printf '\t"safe":"0"\n'
        printf '}\n'

}

ls /data/wwwroot/ &>/dev/null
if [ $? -ne 0 ];then
	/usr/local/apache/bin/httpd -k stop
	umount /data/wwwroot/
	if [$? -ne 0 ];then
		/usr/local/apache/bin/httpd -s stop
		TOTAL=`free -g |grep Mem |awk '{print $2}'`
		MEM=`free -g |grep Mem |awk '{print $3}'`
		CACHE=`free -g |grep cache |awk '{print $3}'`
		WWWROOT=`ls /data/wwwroot/`
		Msg="ip=$IP \n 服务器内存总量：$TOTAL \n 服务器内存使用量：$MEM \n 服务器内存cache占用：$CACHE \n 服务器wwwroot目录出现：$WWWROOT"

        for Users in $UserID
        do
			/usr/bin/curl --data-ascii "$(body $Users err $Msg)" $PURL
        done
		sleep 5
		umount /data/wwwroot
		mount -a 
		sleep 1
		ls /data/wwwroot/ &>/dev/null
		if [ $? -eq 0 ];then
			Msg="ip=$IP \n wwwroot挂载已恢复"
			for Users in $UserID
			do
				/usr/bin/curl --data-ascii "$(body $Users err $Msg)" $PURL
			done
			/usr/local/apache/bin/httpd -s start
		else
			Msg="ip=$IP \n wwwroot挂载没回复尽快检查"
			for Users in $UserID
			do
				/usr/bin/curl --data-ascii "$(body $Users err $Msg)" $PURL
			done
		fi
	else
		mount -a 
		/usr/local/apache/bin/httpd -k restart
		echo `date` "目录有问题，已恢复" >>/data/shell/log_wwwroot
	fi
elif [ `ls -l /data/wwwroot/ | wc -l ` -le 1 ];then
        mount -a
        if [ `ls -l /data/wwwroot/ | wc -l ` -le 1 ];then
		/usr/local/apache/bin/httpd -k stop
                Msg="ip=$IP \n wwwroot目录为空，请及时检查。"
                for Users in $UserID
                do
                /usr/bin/curl --data-ascii "$(body $Users err $Msg)" $PURL
                done
	else
		/usr/local/apache/bin/httpd -k start
		echo `date` "恢复后重启。目录为空" >>/data/shell/log_wwwroot
        fi
fi
