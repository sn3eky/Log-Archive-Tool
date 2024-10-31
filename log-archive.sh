#!/bin/bash
# Test if executed as root
if [[ $EUID -ne 0 ]];
then
    echo "This should be executed as root"
else
    date=$(date '+%d%m%Y_%H%M%S')
    # Test if argument exist
    if [ "$#" -ne 1 ]; 
    then
        echo "Usage: $0 <log_directory>"
        exit 1
    fi

    if [ -d "$1" ];
    then
        if [ -d ./new_logs/ ]
        then
            mkdir ./new_logs/$1
            tar czf ./new_logs/$1/${1}_${date}.tar.gz $1
        else
            mkdir ./new_logs/
        fi
    else
        echo "Usage: $0 <log_directory>"
        echo "Directory doesn't exist"
    fi
fi
