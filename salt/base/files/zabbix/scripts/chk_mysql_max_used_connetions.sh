#!/bin/bash

#mysql当前连接数
mysql -ucigdba -p59A[Saoth1lu#6]8 -e"show processlist;" 2>/dev/null |sed -n '2,$ p' |wc -l

