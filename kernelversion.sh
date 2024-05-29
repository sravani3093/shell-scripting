#!/bin/bash

VERSION=$(uname -r)
for i in hosts
{
    ssh centos@i
    $VERSION | grep -i 4.18.0-535.*
    if [ $? -ne 0 ]
    then
    
        echo " There are no default kernel value"
    else
        echo "kernel varsion of host are :$i"
    
    fi
    exit
}