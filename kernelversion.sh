#!/bin/bash

VERSION=$(uname -a)
For i in hosts
{
    $VERSION | grep -i *.212
    if [$? -ne 0 ];then
    {
        echo " There are no default kernel value"
    else
        echo "kernel varsion of host are :$i"
    }
    fi
}