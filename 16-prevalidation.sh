#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILES=/tmp/$0_$TIMESTAMP.log
user_details(){
   echo "=== user details ===" >> $LOGFILE
   USERNAME=$(who am i) #validating the user details who is running the script
    echo " preshutdown validation started by :$USERNAME at $TIMESTAMP" &>>$LOG_FILES
}

is_physical() {
    lscpu | grep -q Hypervisor
    if [ $? -eq 0 ]; then
        echo "Server Type: Virtual Machine"
    else
        echo "Server Type: Physical Server"
    fi
collect_system_info() {
    echo "=== System Information ===" >> $LOGFILE
    uname -a >> $LOGFILE
    cat /etc/redhat-release
    echo >> $LOGFILE
}

IPADDRESS_DETAILS(){
   echo "=== IP Details ===" >> $LOGFILE
    ifconfig >> $LOGFILE
    ls /etc/sysconfig/network-secritps >> $LOGFILE
    cat /etc/sysconfig/network-secritps/ifcfg-* >> $LOGFILE
}
collect_cpu_memory_info() {
    echo "=== CPU and Memory Usage ===" >> $LOGFILE
    top -bn1 | awk '/Cpu/ { print "CPU Usage: " $2 "%" }' >> $LOGFILE
    free -m | awk '/Mem/ { print "Memory Usage: " $3 " MB" }' >> $LOGFILE
    lscpu >> $LOGFILE
    free -g >> $LOGFILE
    echo >> $LOGFILE
    sar -r 5 10 &>>$LOG_FILES
    sar 5 10 &>>$LOG_FILES

}
# Collect running services
collect_running_services() {
    echo "=== Running Services ===" >> $LOGFILE
    systemctl list-units --type=service --state=running >> $LOGFILE
    echo >> $LOGFILE
}

# Collect filesystem details
collect_filesystem_info() {
    echo "=== Filesystem Details ===" >> $LOGFILE
    df -h >>  $LOGFILE
    cat /etc/fstab >> $LOGFILE
    vgs >> $LOGFILE
    lvs >> $LOGFILE
    lsblk >> $LOGFILE
    echo >> $LOGFILE
}
# Display multipath and PowerMT (if physical server)
collect_multipath_powermt() {
    if [ -f /etc/multipath.conf ]; then
        echo "=== Multipath Configuration ===" >> $LOGFILE
        cat /etc/multipath.conf >> $LOGFILE
        multipath -ll >> $LOGFILE
        echo >>  $LOGFILE
    fi

    if command -v powermt &>/dev/null; then
        echo "=== PowerMT Information ===" >> >> $LOGFILE
        powermt display dev=all >> ">> $LOGFILE
        echo >>  $LOGFILE
    fi
}
main() {
    is_physical
    collect_system_info
    collect_cpu_memory_info
    collect_running_services
    collect_filesystem_info
    collect_multipath_powermt
}

# Execute the main function
main


cat $LOG_FILES #fetching the log files which prevalidation has been completed
echo "pre validation has been completed and log file stored in /tmp"

if [ $ID -ne 0 ] #root user validation
then
   echo -e "\e[31m ERROR:you are not root user, to reboot the server please run as root user \e[0m"
   exit 1
else
   echo -e "\e[32m proceeding to reboot the server \e[0m" #if root user validation is success then proceed to reboot hte server
fi
#reboot &>>$LOG_FILES  #reboot  the server 



   