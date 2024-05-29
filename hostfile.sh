#!/bin/bash
USERNAME=centos
HOSTS="/home/centos/hosts"
SCRIPT="/home/centos/shell-scripting/sh kernelversion.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done