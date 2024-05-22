#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILES=/tmp/$0_$TIMESTAMP.log
is_physical() {
    lscpu | grep -q Hypervisor
    if [ $? -eq 0 ]; then
        echo "Server Type: Virtual Machine"
    else
        echo "Server Type: Physical Server"
    fi
USERNAME=$(who am i) #validating the user details who is running the script
echo " preshutdown validation started by :$USERNAME at $TIMESTAMP" &>>$LOG_FILES
VALIDATE(){
    echo "---------------------------------------" &>>$LOG_FILES
    echo " $1  :" &>>$LOG_FILES
}
#fetching prevalidation outputs in log files
VALIDATE "OS VERSION IS"
uname -a
cat /etc/redhat-release
VALIDATE "checking physical/vmc"
dmidecode -t system-serial-number

VALIDATE "Memory Info &Utilization details are "
free -g &>>$LOG_FILES
sar -r 5 10 &>>$LOG_FILES

VALIDATE "CPU Info &Utilization details "
lscpu &>>$LOG_FILES
sar 5 10 &>>$LOG_FILES

VALIDATE "DISK INFORMATION IS"
df -h &>>$LOG_FILES
sar -d -p 2 4 &>>$LOG_FILES
cat /etc/fstab &>>$LOG_FILES
echo -e " \e[33m LVM Details are \e[0m" &>>$LOG_FILES
vgs &>>$LOG_FILES
lvs &>>$LOG_FILES
pvs &>>$LOG_FILES
lsblk &>>$LOG_FILES



VALIDATE "ip address info"
ifconfig &>>$LOG_FILES

cat $LOG_FILES #fetching the log files which prevalidation has been completed
echo "pre validation has been completed and log file stored in /tmp"

if [ $ID -ne 0 ] #root user validation
then
   echo -e "\e[31m ERROR:you are not root user, to reboot the server please run as root user \e[0m"
   exit 1
else
   echo -e "\e[32m proceeding to reboot the server \e[0m" #if root user validation is success then proceed to reboot hte server
fi
reboot &>>$LOG_FILES  #reboot  the server 



   