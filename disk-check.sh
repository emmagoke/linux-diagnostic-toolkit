#!/bin/bash

args=("$@")

############################################################
# Help                                                     #
############################################################
Help() {
    # Display Help
    echo "This script checks disk usage and provides information about disk space."
    echo

    echo "Syntax: disk-check.sh <threshold> [path]"
    echo 
    echo "threshold     required, integer from 1–100"
    echo "path          optional, defaults to '/'"
}


############################################################
############################################################
# Main program                                             #
############################################################
############################################################

while getopts ":h" option; do
    case $option in
        h) # display Help
            Help
            exit;;
    esac
done
echo "Args: ${args[@]}"
echo "$1"

# Help
echo "${getopts[@]}"
echo "===== Disk Usage Information ====="
