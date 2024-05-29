#!/bin/bash
PWD=$(pwd)
FILEINFO=$(ls-ltr)

if [ $PWD ne 0 ]
then  
   echo "Command failed"
else
   echo " current directory is: $PWD"
   echo "$FILEINFO"
fi
   
   