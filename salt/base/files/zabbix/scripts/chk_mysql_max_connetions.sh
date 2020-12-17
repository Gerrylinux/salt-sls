#!/bin/bash

#获取mysql最大连接数
mysql -ucigdba -p59A[Saoth1lu#6]8  -e "show variables like 'max_connections';"| grep -v Value |awk '{print $2}'

