#!/bin/bash
#HOSTS="ip-172-31-22-212.ec2.internal ip-172-31-19-231.ec2.internal ip-172-31-16-84.ec2.internal "
FILE="/home/centos/shell-scripting/hosts"
VERSION=$(uname -r)
#USERNAME=centos
#for HOSTNAME in ${HOSTS} ; do
  ##  ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
#done
for hosts in ${FILE[@]}
do

    ssh centos@$hosts
    $VERSION | grep -i 4.18.0-535.*
    if [ $? -ne 0 ]
    then
    
        echo " There are no default kernel value"
    else
        echo "kernel varsion of host are :$hosts"
    
    fi
    exit

done
