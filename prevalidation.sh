#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILES=/tmp/$0_$TIMESTAMP.log
#fetching prevalidation outputs in log files
free -g &>>$LOG_FILES
lscpu &>>$LOG_FILES
cat /etc/fstab &>>$LOG_FILES
df -h &>>$LOG_FILES
ifconfig &>>$LOG_FILES
cat $LOG_FILES
echo "pre validation has been completed and log file stored in /tmp"
if [ $ID -ne 0 ]
then
   echo -e "\e[31m ERROR:you are not root user,please run as root user \e[0m"
   exit 1
else
   echo -e "\e[32m proceeding to reboot the server \e[0m"
fi
reboot &>>$LOG_FILES



   