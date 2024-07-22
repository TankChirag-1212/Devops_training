#!/bin/bash

### Script Initialization

# Initialize variables and configurations
LOG_FILE="system_monitor.log"
REPORT_FILE="report.txt"
ALERT_THRESHOLD_CPU=50  
ALERT_THRESHOLD_MEM=50  
EMAIL_ADDRESS="chirag.tank@einfochips.com"
SYSLOG_FILE="/var/log/syslog"
SEVERITY=("ERROR", "WARNING", "CRITICAL")

# Validate required commands and utilities availability
check_commands() {
    local commands=("top" "df" "free" "netstat" "grep" "awk" "mail")
    for cmd in "${commands[@]}"; do
        if ! command -v "$cmd" > /dev/null; then
            echo "Error: '$cmd' command not found. Please install it."
            exit 1
        fi
    done
}

echo "-------------------------------------------------------------------------------"


### System Metrics Collection:

system_metrics() {
# to display CPU utilization
    echo "CPU Usage:"
    mpstat 1 1

# to display memory utilization
    echo "Memory Utilization:"
    free -m

# to display disk space
    echo "Disk Space:"
    df -h

# to display network statistics
    echo "Network Statistics:"
    netstat -s

# to display top processes consuming resources
    echo "Top Processes by CPU and Memory Usage:"
    ps aux --sort=-%cpu,%mem | head -n 11

}

echo "-------------------------------------------------------------------------------"

### Log Analysis: 

generate_summary() {
    for severity in ${SEVERITY[@]}; do
        echo "$severity":
        grep -i $severity $SYSLOG_FILE
        echo "-----------------------------"
}

### Health Checks: 

perform_health_check() {
    systemctl status apache2
    echo "-----------------------------"
    systemctl status mysql
    echo "-----------------------------"
    echo "Verifying Connectivity to External Services:"
    ping -c 4 google.com
    mysql -h localhost -u root -p'password' -e 'SELECT 1'
}