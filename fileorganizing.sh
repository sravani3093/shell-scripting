#!/bin/bash

SOURCE="/home/centos"
TIMESTAMP=$(date +%F-%H-%M-%s)
DATE=$(date)
cd /tmp/sravani
mkdir  -p /Script_$TIMESTAMP

cd $SOURCE
PATH=$(ls -lrt |grep "$(date +'%b %d')" |awk '{print $9}')
while IFS= read -r line
do
   rm-rf $line 
done <<< $PATH