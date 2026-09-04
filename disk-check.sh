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
# Logging                                                   #
############################################################
LOG_DIR="$(dirname "$0")/logs"
LOG_FILE="$LOG_DIR/$(basename "$0" .sh).log"

mkdir -p "$LOG_DIR"

log() {
    local message="$1"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
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
shift $((OPTIND - 1))

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
# echo "${getopts[@]}"
############################################################
# Main check                                                #
############################################################
echo "===== Disk Usage Information ====="


log "Checking disk usage for path='$path' with threshold=${threshold}%"
usage=$(df -h "$path" | awk 'NR==2 {print $5}' | tr -d '%')

echo "Path: $path"
echo "Disk usage: ${usage}%"
echo "Threshold: ${threshold}%"

if [ "$usage" -ge "$threshold" ]; then
    log "WARNING: usage ${usage}% >= threshold ${threshold}% for path '$path'"
    echo "Status: WARNING - usage has reached or exceeded the threshold."
    exit 1
else
    log "OK: usage ${usage}% is below threshold ${threshold}% for path '$path'"
    echo "Status: OK - usage is below the threshold."
    exit 0
fi
