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

# echo "Args: ${args[@]}"
# echo "$1"
threshold="$1"
path="${2:-/}"  # Default to '/' if no path is provided

############################################################
# Validate input                                            #
############################################################
if [ -z "$threshold"]; then
    echo "Error: threshold is required." >&2
    Help
    exit 2
fi


# Help
echo "${getopts[@]}"
echo "===== Disk Usage Information ====="
