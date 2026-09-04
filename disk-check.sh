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

# df -h "$path"

# df = "disk free" — shows filesystem usage. -h = human-readable sizes 
# K/M/G instead of raw byte counts). Running it on a path, say /home, gives output like:

# Filesystem      Size  Used Avail Use% Mounted on
# /dev/sda1        50G   32G   16G  67% /

# Line 1 is the header, line 2 is the actual data row for that path.

#  awk 'NR==2 {print $5}'

# This takes that df output and pulls out one specific piece:

# NR = "Number of Record" — the current line number awk is processing
# NR==2 = "only act on line 2" (skips the header line)
# {print $5} = print the 5th column of that line

# Columns in awk are split by whitespace automatically, so counting the df output:

# $1=Filesystem  $2=Size  $3=Used  $4=Avail  $5=Use%  $6=Mounted on

# So $5 is 67% — exactly the usage percentage, nothing else.

# tr -d '%'

# tr = "translate" characters. -d '%' = delete every % character from the input. So 67% becomes just 67.
usage=$(df -h "$path" | awk 'NR==2 {print $5}' | tr -d '%')

echo "Path: $path"
echo "Disk usage: ${usage}%"
echo "Threshold: ${threshold}%"

if [ "$usage" -ge "$threshold" ]; then
    echo "Status: WARNING - usage has reached or exceeded the threshold."
    exit 1
else
    echo "Status: OK - usage is below the threshold."
    exit 0
fi
