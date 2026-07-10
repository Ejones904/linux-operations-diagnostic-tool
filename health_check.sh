#!/bin/bash
# ****************************************
# Linux Operations Diagnostic Tool
# Author: Ethan Jones
# Description:
# Performs common Linux system health checks
# *****************************************

HOSTNAME=$(hostname)
CURRENT_USER=$(whoami)
CURRENT_DATE=$(date)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
IP_ADDRESS=$(hostname -I)
USER_ID=$(id -u)
GROUPS=$(groups)

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}')

NETWORK_INTERFACE=$(ip route | awk '/default/ {print $5}')
GATEWAY=$(ip route | awk '/default/ {print $3}')
PING_RESULT=$(ping -c 1 google.com >/dev/null 2>&1 && echo "SUCCESS" || echo "FAILED")

SSH_STATUS=$(systemctl is-active ssh 2>/dev/null)

REPORT_FILE="reports/linux_health_report.txt"

print_header() {
	echo "*************************************"
	echo " Linux Operations Diagnostic Tool"
	echo "*************************************"
	echo ""
}

system_information() {
	echo "SYSTEM INFORMATION"
	echo "******************"

	echo "Hostname: $HOSTNAME"

	echo "Current User: $CURRENT_USER"

	echo "Date: $CURRENT_DATE"

	echo "Kernel Version: $KERNEL"

	echo "System Uptime: $UPTIME"

	echo ""
}

user_information() {
	echo "USER INFORMATION"
	echo "****************"

	echo "Username:$CURRENT_USER"

	echo "User ID:$USER_ID"

	echo "Groups:$GROUPS"

	echo ""
}


resource_check() {
	echo "RESOURCE CHECK"
	echo "**************"

	echo "Memory Usage:${MEMORY_USAGE}%"

	if [ "$MEMORY_USAGE" -gt 80 ]; then
		echo "Memory Status:WARNING"
	else
		echo "Memory Status:HEALTHY"
	fi

	echo ""

	echo "Disk Usage: ${DISK_USAGE}%"

	if [ "$DISK_USAGE" -gt 80 ]; then
		echo "Disk Status:WARNING"
	else
		echo "Disk Status:HEALTHY"
	fi

	echo ""

	echo "CPU Load:$CPU_LOAD"

	echo ""
}

network_check() {
	echo "NETWORK CHECK"
	echo "*************"

	echo "Interface:$NETWORK_INTERFACE"

	echo "Gateway:$GATEWAY"

	echo "Connectivity Test:$PING_RESULT"

	echo ""
}

service_check() {
	echo "SERVICE CHECK"
	echo "*************"

	echo "SSH Service Status:$SSH_STATUS"

	if [ "$SSH_STATUS" = "active" ]; then
		echo "SSH Status:HEALTHY"
	else
		echo "SSH Status:WARNING"
	fi

	echo ""
}

generate_report() {

    echo "Generating report..."

    echo "Linux Operations Diagnostic Report" > $REPORT_FILE
    echo "==================================" >> $REPORT_FILE

    echo "" >> $REPORT_FILE

    echo "Generated: $CURRENT_DATE" >> $REPORT_FILE

    echo "" >> $REPORT_FILE

    echo "SYSTEM INFORMATION" >> $REPORT_FILE
    echo "******************" >> $REPORT_FILE
    echo "Hostname: $HOSTNAME" >> $REPORT_FILE
    echo "Kernel: $KERNEL" >> $REPORT_FILE
    echo "User: $CURRENT_USER" >> $REPORT_FILE

    echo "" >> $REPORT_FILE

    echo "RESOURCE STATUS" >> $REPORT_FILE
    echo "***************" >> $REPORT_FILE
    echo "Memory Usage: $MEMORY_USAGE%" >> $REPORT_FILE
    echo "Disk Usage: $DISK_USAGE%" >> $REPORT_FILE

    echo "" >> $REPORT_FILE

    echo "NETWORK STATUS" >> $REPORT_FILE
    echo "**************" >> $REPORT_FILE
    echo "Connectivity: $PING_RESULT" >> $REPORT_FILE

    echo "" >> $REPORT_FILE

    echo "SERVICE STATUS" >> $REPORT_FILE
    echo "**************" >> $REPORT_FILE
    echo "SSH: $SSH_STATUS" >> $REPORT_FILE

    echo "Report saved to $REPORT_FILE"

}
print_header
system_information
user_information
resource_check
network_check
service_check
generate_report
