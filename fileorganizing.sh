#!/bin/bash
TARGETDIR=/tmp/sravani
SOURCE= echo "please provide the source path"
read $SOURCE
TIMESTAMP=$(date +%F-%H-%M-%s)
DATE=$(date)

if [ -f $SOURCE]
then
   PATH = find $SOURCE  -type f -mtime date -name  "*"
   if [ $? ne 0]
   then
       echo "there are no files generated on :$DATE"
    else
       FILE=$(mkdir -P /$TARGETDIR/scripts_$TIMESTAMP)
       mv $PATH $FILE
    fi
else 
    echo "Directory not exist"
fi
       
