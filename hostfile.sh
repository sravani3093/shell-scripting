#!/bin/bash
USERNAME=centos
HOSTS="ip-172-31-22-212.ec2.internal ip-172-31-19-231.ec2.internal ip-172-31-16-84.ec2.internal "
SCRIPT="/home/centos/shell-scripting/kernelversion.sh"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done