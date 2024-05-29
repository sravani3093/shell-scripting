#!/bin/bash
USERNAME=centos
SERVERLIST=hosts.dat
SCRIPT="/home/centos/shell-scripting/kernelversion.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done