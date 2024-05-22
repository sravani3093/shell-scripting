#!/bin/bash
# Server Information Collection Script

# Output file for the collected information
OUTPUT_FILE="/tmp/server_info.txt"

# Check if the server is physical or virtual
is_physical() {
    lscpu | grep -q Hypervisor
    if [ $? -eq 0 ]; then
        echo "Server Type: Virtual Machine"
    else
        echo "Server Type: Physical Server"
    fi
}

# Collect system information
collect_system_info() {
    echo "=== System Information ===" >> "$OUTPUT_FILE"
    uname -a >> "$OUTPUT_FILE"
    lsb_release -a >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Collect CPU and memory usage
collect_cpu_memory_info() {
    echo "=== CPU and Memory Usage ===" >> "$OUTPUT_FILE"
    top -bn1 | awk '/Cpu/ { print "CPU Usage: " $2 "%" }' >> "$OUTPUT_FILE"
    free -m | awk '/Mem/ { print "Memory Usage: " $3 " MB" }' >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Collect running services
collect_running_services() {
    echo "=== Running Services ===" >> "$OUTPUT_FILE"
    systemctl list-units --type=service --state=running >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Collect filesystem details
collect_filesystem_info() {
    echo "=== Filesystem Details ===" >> "$OUTPUT_FILE"
    df -h >> "$OUTPUT_FILE"
    echo >> "$OUTPUT_FILE"
}

# Display multipath and PowerMT (if physical server)
collect_multipath_powermt() {
    if [ -f /etc/multipath.conf ]; then
        echo "=== Multipath Configuration ===" >> "$OUTPUT_FILE"
        cat /etc/multipath.conf >> "$OUTPUT_FILE"
        echo >> "$OUTPUT_FILE"
    fi

    if command -v powermt &>/dev/null; then
        echo "=== PowerMT Information ===" >> "$OUTPUT_FILE"
        powermt display dev=all >> "$OUTPUT_FILE"
        echo >> "$OUTPUT_FILE"
    fi
}

# Main function
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

echo "Server information collected. Check $OUTPUT_FILE."
