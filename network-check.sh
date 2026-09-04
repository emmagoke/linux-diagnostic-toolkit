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
