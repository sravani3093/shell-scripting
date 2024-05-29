#!/bin/bash

SOURCE_DIR="/home/centos"
TIMESTAMP=$(date +%F-%H-%M-%s)
mkdir -p /tmp/sravani/Script_$TIMESTAMP

PATH=$(ls -lrt $SOURCE_DIR |grep "$(date +'%b %d')" |awk '{print $9}')
while IFS= read -r line
do
   mv $line  /tmp/sravani/Script_$TIMESTAMP
done < $PATH