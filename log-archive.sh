#!/bin/bash
check_command(){
    if [ $? -eq 0 ]; then
        echo "Done with success!"
    else
        echo "The program failed"
        exit 1
    fi
}

create_archive(){
    date=$(date '+%d%m%Y_%H%M%S')
    # Test if argument exist
    if [ "$#" -ne 1 ];
    then
        echo "Usage: $0 <log_directory_to_compress>"
        exit 1
    else
        if [ -d "$1" ];
        then
            if [ -d /var/log/new_logs ];
            then
                mkdir -p /var/log/new_logs/$1
                echo "Creating archive.."
                tar czf /var/log/new_logs/$1/${1}_${date}.tar.gz $1
                check_command
            else
                echo "Creating folder.."
                mkdir -p /var/log/new_logs
                check_command
            fi
        else
            echo "Usage: $0 -c <log_directory>"
            echo "Directory doesn't exist.. specify a correct one"
            exit 1
        fi
    fi
}

Help(){
    echo "Tool to archive old logs to new directory"
    echo
    echo "Syntax: [-h | -c | -u]"
    echo "Options:"
    echo "-h     Print Help"
    echo "-c     Compress folder to new directory"
    echo "-u     Uncompress the archive.. (In development)"   
}
   
# Test if executed as root
if [[ $EUID -ne 0 ]];
then
    echo "This should be executed as root"
else
    while getopts ":hc" option; do
        case $option in
        h) 
            Help
            exit ;;
        c)
            create_archive $2;
            exit ;;
        \?)
            echo "Invalid Option"
            Help
            exit ;;
        esac
    done
    Help
fi
