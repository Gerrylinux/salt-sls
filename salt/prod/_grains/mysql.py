#!/usr/bin/env python
#coding:utf-8
#定义mysql配置文件、日志等信息

import os,commands
def mysql():
  grains = {}
  mysql_bin = commands.getoutput("ps -ef | grep mysql|grep -v grep |grep user|awk '{print $8}'")
  if os.path.exists(mysql_bin):
    grains['mysql_version'] = commands.getoutput("echo `$(ps -ef | grep mysql|grep -v grep |grep user|awk '{print $8}') -V 2>/dev/null` | awk '{print $3}'").split('\n')
    grains['mysql_dir'] = commands.getoutput("ps -ef | grep mysql|grep -v grep |grep user|awk '{print $9}'| awk -F'=' '{print $2}'").split('\n')
  return grains

if __name__ == '__main__':
    nginx()
