#!/bin/bash
TARGET_DIR="/tmp/sravani"
SOURCE_DIR="/home/centos/sravani"
PATH=$(ls -lrt $SOURCE_DIR |grep "$(date +'%b %d')" |awk '{print $9}')

echo "$PATH"
