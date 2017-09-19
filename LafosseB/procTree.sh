#!/bin/bash

# Displays help
function help() {
    echo "Use: ./procTree.sh [PID (optionnal)]"
    exit
}

# Fetch all children of a given Parent
function getChildPID() {
    cpids=`pgrep -P $1|xargs`
# Displaying PIDs
    for cpid in $cpids;
    do
        echo "    $cpid"
        #getChildPID $cpid
    done
}

#function getProcessName()
#{
#
#}

function main() {
# Testing if user is calling for help
    if [[ $1 == "--help" ]]
    then
        help
    fi

# Testing if the user gave a write parametter
    if [ $# -gt 1 ]
    then
        echo "Please provide only one parameter to check"
    else
        if [ $# -eq 0 ]
        then
            echo "No parameter given -> show all processes..."
            processList=$(ls /proc | grep -e ^[0-9])
            for process in $processList;
            do
                echo "$process"
                getChildPID $process
            done
        else
            echo "Showing children of the PID -> $1"
            getChildPID $1
        fi
    fi
}

main $@
