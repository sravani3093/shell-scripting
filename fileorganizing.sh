#!/bin/bash
TARGET_DIR="/tmp/sravani"
SOURCE_DIR="/home/centos/sravani"
PATH=$(ls -lrt /home/centos/sravani |grep "$(date +'%b %d')" |awk '{print $9}')

echo "$PATH"
