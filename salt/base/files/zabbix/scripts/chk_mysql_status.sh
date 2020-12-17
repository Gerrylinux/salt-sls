#!/bin/bash

# mysql port
netstat -ntl |grep 3306 |wc|awk '{print $1}'
