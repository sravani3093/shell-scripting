#!/bin/bash
TARGETDIR="/tmp/sravani"
SOURCE="/home/centos"
TIMESTAMP=$(date +%F-%H-%M-%s)
DATE=$(date)

cd $SOURCE
PATH=$(ls -lrt |grep "$(date +'%b %d')" |awk '{print $9}')
while IFS= read -r line
do
   echo "file has  to been moved is $line"
    
    
done <<< $PATH
   
cd $TARGETDIR
mkdir  -p /Script_$TIMESTAMP
cp $line  /Script_$TIMESTAMP