#!/bin/bash
# echo "Displays live system information gathered at runtime:"
echo "===== System Information ====="

echo "Hostname: $(hostname)"
echo "Current user: $(whoami)"
# free -h
echo "Date/Time: $(date)"
echo "Operating System: $(source /etc/os-release && echo $PRETTY_NAME)"
echo "Kernel version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "CPU info: $(lscpu | grep 'Model name' | sed 's/Model name:\s*//')"
# echo "Memory usage: $(free -h | grep Mem)"
echo "Memory info: $(free -h | awk '/Mem:/ {print "Total: "$2", Used: "$3", Free: "$4}')"
echo "Current working directory: $(pwd)"
# date 
# # uname -a | grep -oP 'Linux \K.*'
# pwd
# date +%A

# read -p "Name? " name
# echo "Hello, $name! Here is your system information:"
