#!/usr/bin/env python
#coding:utf-8

import os,commands
def backup():
  grains = {}
  backup_dir = '/data/rsyncbackup'
  if os.path.exists(backup_dir):
    grains['backup'] = os.path.exists(backup_dir)
  return grains

if __name__ == '__main__':
    backup()
