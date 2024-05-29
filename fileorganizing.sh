#!/bin/bash
TARGET_DIR="/tmp/sravani"
SOURCE_DIR="/home/centos/sravani"
for file in "$SOURCE_DIR"
do
   if [[ -f $file ]];
   then
   PATH=$(ls -lrt $SOURCE_DIR |grep "$(date +'%b %d')" |awk '{print $9}')
   echo "$PATH"
   fi
done
