#!/bin/bash

############################################################
# Help                                                      #
############################################################
Help() {
    echo "This script performs basic network diagnostics for a given host,"
    echo "with an optional port check."
    echo
    echo "Syntax: network-check.sh <hostname-or-ip> [port]"
    echo
    echo "hostname-or-ip     required, host to check"
    echo "port               optional, integer from 1-65535"
}

############################################################
# Parse flags (only -h supported)                          #
############################################################
while getopts ":h" option; do
    case $option in
        h) Help
           exit 0;;
        \?) echo "Invalid option: -$OPTARG" >&2
            Help
            exit 2;;
    esac
done
shift $((OPTIND - 1))   # remove parsed flags, leave positional args in place


############################################################
# Positional arguments                                      #
############################################################
host="$1"
port="$2"

############################################################
# Validate host argument                                    #
############################################################
if [ -z "$host" ]; then
    echo "Error: hostname or IP is required." >&2
    Help
    exit 2
fi

############################################################
# Validate port argument (if supplied)                      #
############################################################
if [ -n "$port" ]; then
    if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
        echo "Error: port must be an integer from 1 to 65535." >&2
        exit 2
    fi
fi

echo "===== Network Diagnostics ====="
echo "Host: $host"

############################################################
# Resolve host                                               #
############################################################
resolved=$(getent hosts "$host" 2>/dev/null | awk '{print $1}' | head -n1)

if [ -z "$resolved" ]; then
    echo "Resolved address: could not resolve host '$host'"
    echo "Status: FAILED - host resolution failed."
    exit 1
else
    echo "Resolved address: $resolved"
fi
