#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILES=/tmp/$0_$TIMESTAMP.log
VALIDATE(){
    echo "---------------------------------------" &>>$LOG_FILES
    echo " $1 info is :" &>>$LOG_FILES
}
#fetching prevalidation outputs in log files
VALIDATE "Memory info"
free -g &>>$LOG_FILES
VALIDATE "CPU info"
lscpu &>>$LOG_FILES
VALIDATE "fstab info"
cat /etc/fstab &>>$LOG_FILES
VALIDATE "filesystem info"
df -h &>>$LOG_FILES
VALIDATE "ip address info"
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



   