#!/bin/bash
# Linux System Health & Security Auditor
# Created by Yassir Mohammed

REPORT_FILE="system_report.log"

echo "------------------------------------------" > $REPORT_FILE
echo "System Audit Report - $(date)" >> $REPORT_FILE
echo "------------------------------------------" >> $REPORT_FILE

# 1. Disk Usage
echo -e "\n[+] Checking Disk Usage..." >> $REPORT_FILE
df -h | grep '^/dev/' >> $REPORT_FILE

# 2. Memory Usage
echo -e "\n[+] Checking Memory Usage..." >> $REPORT_FILE
free -h >> $REPORT_FILE

# 3. Failed Login Attempts (Security)
echo -e "\n[+] Checking Failed Login Attempts..." >> $REPORT_FILE
# Note: Path might differ between RHEL and Ubuntu
if [ -f /var/log/secure ]; then
    grep "Failed password" /var/log/secure | tail -n 5 >> $REPORT_FILE
elif [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | tail -n 5 >> $REPORT_FILE
else
    echo "No authentication logs found." >> $REPORT_FILE
fi

echo -e "\nAudit Complete. Results saved in $REPORT_FILE"
