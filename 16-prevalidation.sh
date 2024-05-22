#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.logE"
user_details() {
   echo "=== user details ==="  >> "$LOGFILE"
   USERNAME=$(who am i) #validating the user details who is running the script
    echo " preshutdown validation started by :$USERNAME at $TIMESTAMP"  >> "$LOGFILE"
}

is_physical() {
    lscpu | grep -q Hypervisor
    if [ $? -eq 0 ]; 
    then
        echo "Server Type: Virtual Machine"
    else
        echo "Server Type: Physical Server"
    fi
collect_system_info() {
    echo "=== System Information ===" >> "$LOGFILE"
    uname -a >> "$LOGFILE"
    cat /etc/redhat-release >> "$LOGFILE"
    echo >> "$LOGFILE"
}

IPADDRESS_DETAILS() {
   echo "=== IP Details ===" >> "$LOGFILE"
   ifconfig >> "$LOGFILE"
   cat /etc/resolv.conf >> "$LOGFILE"
   for ifcfg_file in /etc/sysconfig/network-scripts/ifcfg-*; do
     if [ -f "$ifcfg_file" ];
     then
        echo "=== $ifcfg_file ===" >> "$LOGFILE"
        cat "$ifcfg_file" >> "$LOGFILE"
        echo >> "$OUTPUT_FILE"  # Add a blank line between files
     fi
done
    
}
collect_cpu_memory_info() {
    echo "=== CPU and Memory Usage ===" >> "$LOGFILE"
    top -bn1 | awk '/Cpu/ { print "CPU Usage: " $2 "%" }' >> "$LOGFILE"
    lscpu >> "$LOGFILE"
    sar 5 10 >> "$LOGFILE"
    echo "======================" >> "$LOGFILE"
    free -m | awk '/Mem/ { print "Memory Usage: " $3 " MB" }' >> "$LOGFILE"
    sar -r 5 10 >> "$LOGFILE"
    echo >> "$LOGFILE"
   
    }
# Collect running services
collect_running_services() {
    echo "=== Running Services ===" >> "$LOGFILE"
    systemctl list-units --type=service --state=running >> "$LOGFILE"
    echo >> "$LOGFILE"
}

# Collect filesystem details
collect_filesystem_info() {
    echo "=== Filesystem Details ===" >> "$LOGFILE"
    df -h >>  "$LOGFILE"
    cat /etc/fstab >> "$LOGFILE"
    pvs >> "$LOGFILE"
    vgs >> "$LOGFILE"
    lvs >> "$LOGFILE"
    lsblk >> "$LOGFILE"
    echo  >> "$LOGFILE"
}
# Display multipath and PowerMT (if physical server)
collect_multipath_powermt() {
    if [ -f /etc/multipath.conf ]; then
        echo "=== Multipath Configuration ===" >> "$LOGFILE"
        cat /etc/multipath.conf >> "$LOGFILE"
        multipath -ll >> "$LOGFILE"
        echo  >> "$LOGFILE"
    fi

    if command -v powermt &>/dev/null; then
        echo "=== PowerMT Information ===" >> "$LOGFILE"
        powermt display dev=all >> "$LOGFILE"
        echo   >> "$LOGFILE"
    fi
}

root_user_validation() {
   if [ $ID -ne 0 ] #root user validation
then
   echo -e "\e[31m ERROR:you are not root user, to reboot the server please run as root user \e[0m"
   exit 1
else
   echo -e "\e[32m proceeding to reboot the server \e[0m" #if root user validation is success then proceed to reboot hte server
fi
}

#server_reboot(){
   #reboot  >> "$LOGFILE" #reboot the server 
#}
main() {
    is_physical
    collect_system_info
    collect_cpu_memory_info
    collect_running_services
    collect_filesystem_info
    collect_multipath_powermt
    IPADDRESS_DETAILS
    root_user_validation
    #server_reboot

}

# Execute the main function
main

