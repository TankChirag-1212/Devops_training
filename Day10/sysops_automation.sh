#!/bin/bash

# Script Initialization
# Initialize variables and configurations
LOG_FILE="system_monitor.log"
REPORT_FILE="report.txt"
ALERT_THRESHOLD_CPU=10   # Example: alert if CPU usage exceeds 80%
ALERT_THRESHOLD_MEM=20   # Example: alert if memory usage exceeds 90%
EMAIL_ADDRESS="chirag.tank@einfochips.com"

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

# System Metrics Collection
collect_system_metrics() {
    echo "=== System Metrics ===" >> "$LOG_FILE"
    echo "Timestamp: $(date)" >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # CPU usage
    top -bn 1 | head -n 10 >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # Memory utilization
    free -h >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # Disk space
    df -h >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # Network statistics
    # netstat -s | grep -i "segments\s*retransm" >> "$LOG_FILE"
    # echo "-------------------------------------" >> "$LOG_FILE"
    netstat -nlp >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # Top processes
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 10 >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"
}

# Log Analysis
analyze_logs() {
    echo "=== Log Analysis ===" >> "$LOG_FILE"
    echo "Timestamp: $(date)" >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # Example: Parse syslog for errors
    grep -i "error" /var/log/syslog >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"
}

# Health Checks
perform_health_checks() {
    echo "=== Health Checks ===" >> "$LOG_FILE"
    echo "Timestamp: $(date)" >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # Example: Check Apache status
    systemctl status apache2 >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"

    # # Example: Check MySQL status
    # systemctl status mysql >> "$LOG_FILE"
    # echo "-------------------------------------" >> "$LOG_FILE"

    # Example: Connectivity checks
    ping -c 3 google.com >> "$LOG_FILE"
    echo "-------------------------------------" >> "$LOG_FILE"
}

# Alerting Mechanism
check_alerts() {
    # Example: Check CPU and Memory thresholds
    local current_cpu_usage=$(top -bn 1 | grep "Cpu(s)" | awk '{print $2}')
    local current_mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

    if (( $(echo "$current_cpu_usage > $ALERT_THRESHOLD_CPU" | bc -l) )); then
        echo "Alert: High CPU usage detected ($current_cpu_usage%)" | mail -s "High CPU Alert" "$EMAIL_ADDRESS"
    fi

    if (( $(echo "$current_mem_usage > $ALERT_THRESHOLD_MEM" | bc -l) )); then
        echo "Alert: High Memory usage detected ($current_mem_usage%)" | mail -s "High Memory Alert" "$EMAIL_ADDRESS"
    fi
}

# Report Generation
generate_report() {
    echo "=== System Monitoring Report ===" > "$REPORT_FILE"
    echo "Timestamp: $(date)" >> "$REPORT_FILE"
    echo "-------------------------------------" >> "$REPORT_FILE"

    # Append content from LOG_FILE to REPORT_FILE
    cat "$LOG_FILE" >> "$REPORT_FILE"

    echo "Report generated: $REPORT_FILE"
}

# Main function
main() {
    check_commands
    collect_system_metrics
    analyze_logs
    perform_health_checks
    check_alerts
    generate_report
}

# Execute main function
main
