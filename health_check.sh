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
print_header
system_information
user_information
resource_check
network_check
