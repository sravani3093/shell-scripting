#!/bin/bash
TARGETDIR="/tmp/sravani"
SOURCE="/home/centos"
TIMESTAMP=$(date +%F-%H-%M-%s)
DATE=$(date)

if [ -d $SOURCE ]
then
   cd $SOURCE
   PATH=$(ls -lrt |grep "$(date +'%b %d')" |awk '{print $9}')
   while IFS= read -r line
   do
      cd $TARGETDIR
      mkdir Script_$TIMESTAMP
      cp $line Script_$TIMESTAMP
      echo "file has been moved successfully: $line"
    
    done <<< $PATH
else 
    echo "Directory not exist"
fi
       
