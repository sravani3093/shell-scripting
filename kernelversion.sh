#!/bin/bash
FILE=/home/centos/shell-scripting/hosts
VERSION=$(uname -r)
for hosts in ${FILE[@]}
{
    ssh centos@i
    $VERSION | grep -i 4.18.0-535.*
    if [ $? -ne 0 ]
    then
    
        echo " There are no default kernel value"
    else
        echo "kernel varsion of host are :$hosts"
    
    fi
    exit
}
