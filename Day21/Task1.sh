#!/bin/bash

CURRENT_DATE=$(date +'%Y%m%d_%H%M%S')
LOGFILE="/home/einfochips/Downloads/Ansible/Day21-task/Log_dir/Logfile_$CURRENT_DATE.log"


echo "Running System Performance Metrics Check at $(date)" >> $LOGFILE

{
    echo "Disk Usage:"
    df -h
    echo ""

    echo "Memory Usage:"
    free -h
    echo ""

    echo "CPU Load:"
    top -b -n1 | grep "Cpu(s)"
} 2>&1 | tee -a $LOGFILE

echo "" >> $LOGFILE

echo "System Performance Metrics check complete. Check log file at $LOGFILE for details."