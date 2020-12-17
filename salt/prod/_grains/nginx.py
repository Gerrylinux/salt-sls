#!/usr/bin/env python
#coding:utf-8
#定义nginx配置文件、日志等信息

import os,commands
def nginx():
  grains = {}
  nginx_bin = commands.getoutput("ps -ef | grep nginx  |grep master| grep -v grep |awk '{print $11}'")
  if os.path.exists(nginx_bin):
    grains['nginx_version'] = commands.getoutput("echo `$(ps -ef | grep nginx  |grep master| grep -v grep |awk '{print $11}') -v 2>&1` | cut -c22-").split('\n')
    grains['nginx_dir'] = commands.getoutput("echo `$(ps -ef | grep nginx  |grep master| grep -v grep |awk '{print $11}') -V 2>&1` | awk -F'prefix=' '{print $2}'|awk '{print $1}'").split('\n')
  return grains

if __name__ == '__main__':
    nginx()
