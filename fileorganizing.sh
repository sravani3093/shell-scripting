#!/bin/bash
TARGETDIR=/tmp/sravani
SOURCE=echo "please provide the source path"
read $SOURCE
TIMESTAMP=$(date +%F-%H-%M-%s)
DATE=$(date)

if [ -f $SOURCE ]
then
   cd $SOURCE
   PATH=$(ls -lrt |grep "$(date +'%b %d')" |awk '{print $9}')
   while IFS= read -r line
   do
      cd $TARGETDIR
       mkdir Script_$TIMESTAMP
       mv $line Script_$TIMESTAMP
       echo "file has been moved successfully: $line"
    
done <<< $PATH
else 
    echo "Directory not exist"
fi
       
