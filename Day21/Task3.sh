#!/bin/bash

# Configuration
LOG_DIR="./Log_dir"                     # Directory containing the logs
ARCHIVE_DIR="./Archived_logs"           # Directory to store archived logs
RETENTION_DAYS=1                        # Number of days to retain logs
MAX_LOG_SIZE=10485760                   # Maximum log file size in bytes (10MB)
REPORT_FILE="./Reports/log_manage_report.txt" # Report file

# Ensure the archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Create or clear the report file
: > "$REPORT_FILE"

echo "Log Management Report - $(date)" >> "$REPORT_FILE"
echo "===================================" >> "$REPORT_FILE"

# Function to check log size and rotate if necessary
rotate_log() {
    local logfile="$1"
        if [ ! -f "$logfile" ]; then
            echo "Log file not found: $logfile" >> "$REPORT_FILE"
            return 1
        fi

        local logsize=$(stat -c%s "$logfile")

        if (( logsize > MAX_LOG_SIZE )); then
            local current_date=$(date +'%Y%m%d_%H%M%S')
            local archived_log="$ARCHIVE_DIR/$(basename "$logfile")"
            
            mv "$logfile" "$archived_log" 2>>"$REPORT_FILE"
            if [ $? -ne 0 ]; then
                echo "Error rotating log file: $logfile" >> "$REPORT_FILE"
                return 1
            fi
            
            echo "Rotated log file: $logfile to $archived_log" >> "$REPORT_FILE"
            
            # Compress the rotated log file
            gzip "$archived_log" 2>>"$REPORT_FILE"
            if [ $? -eq 0 ]; then
            echo "Rotated log file: $logfile to $archived_log" >> "$REPORT_FILE"
            gzip "$archived_log"
            if [ $? -eq 0 ]; then
                echo "Compressed log file: $archived_log.gz" >> "$REPORT_FILE"
            else
                echo "Error compressing log file: $archived_log" >> "$REPORT_FILE"
            fi
        else
            echo "Error rotating log file: $logfile" >> "$REPORT_FILE"
            return 1
        fi
    else
        echo "Log file size is within limits: $logfile (Size: $logsize bytes)" >> "$REPORT_FILE"
    fi
    return 0
}

# Function to delete old logs
delete_old_logs() {

    find "$ARCHIVE_DIR" -type f -name "*.gz" -mtime +$RETENTION_DAYS -exec rm -v {} \; >>"$REPORT_FILE" 2>>&1
    if [ $? -eq 0 ]; then
        echo "Logs older than $RETENTION_DAYS days deleted." >> "$REPORT_FILE"
    else
        echo "Error deleting old logs." >> "$REPORT_FILE"
    fi
}

# Main script execution
echo "Starting log management tasks..." >> "$REPORT_FILE"

for logfile in "$LOG_DIR"/Logfile*.log; do
    rotate_log "$logfile"
done

delete_old_logs

echo "Log management tasks completed." >> "$REPORT_FILE"

# Display the report
cat "$REPORT_FILE"

# Optionally, restart the logging service (uncomment if needed)
# service myapp restart