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

####################################################################
# Validate input                                                   #
#                                                                  #
# the -z operator checks if a string is zero length (i.e., empty). #
# [ -z "$threshold" ] returns true if $threshold is empty
# (no value was provided).
#
# [ -n "$threshold" ] (the opposite) checks if a string is 
#  non-zero length (i.e., not empty).
####################################################################
if [ -z "$threshold" ]; then
    echo "Error: threshold is required." >&2
    Help
    exit 2
fi

if ! [[ "$threshold" =~ ^[0-9]+$ ]] || [ "$threshold" -lt 1 ] || [ "$threshold" -gt 100 ]; then
    echo "Error: threshold must be an integer from 1 to 100." >&2
    Help
    exit 2
fi

if [ ! -d "$path" ]; then
    echo "Error: path '$path' does not exist or is not a directory." >&2
    Help
    exit 2
fi


# Help
echo "${getopts[@]}"
echo "===== Disk Usage Information ====="
