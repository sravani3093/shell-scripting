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
   if [ $? ne 0 ]
   then
       echo "there are no files generated on :$DATE"
    else
       cd $TARGETDIR
       DIR=$(mkdir Script_$TIMESTAMP)
       mv $PATH $DIR
    fi
else 
    echo "Directory not exist"
fi
       
