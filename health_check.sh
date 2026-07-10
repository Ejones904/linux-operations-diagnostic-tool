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

print_header
system_information
user_information


