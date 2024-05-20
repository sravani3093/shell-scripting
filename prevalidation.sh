#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date-+%F-%H:%M:%S)
LOG_FILES=/tmp_$0_$TIMESTAMP.log
if [ $ID -ne 0 ]
then
   echo -e "\e[31m ERROR:you are not root user,please login as root user and run \e[0m"
else
   echo -e "\e[32m starting the pre-validateion process \e[0m]"

#fetching prevalidation outputs in log files
free -g &>>$LOG_FILES
lscpu &>>$LOG_FILES
cat /etc/fstab &>>$LOG_FILES
df -h &>>$LOG_FILES
ifconfig &>>$LOG_FILES



   