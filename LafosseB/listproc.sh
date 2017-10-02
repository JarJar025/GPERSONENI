#!/bin/bash

# Analysing the fetched state of a given process
function compareState()
{
    if [ $1 == "S" ]
    then
        statusProcV="WAITING"
    else
        if [[ $1 == *"Z"* ]]
        then
            statusProcV="ZOMBIE"
        else
            statusProcV="OTHER"    
        fi
    fi
}

# Main function
function main()
{
    listeProc=$(ls /proc | grep -e ^[0-9])

# Columns headers
    printf "%-5s | %-15s | %-5s\n" "PID" "NAME" "STATE"

# Processing every processes found
    for proc in $listeProc
    {
        if [ -e /proc/$proc/status ] 
        then

# Fetching the required elements
            nomProc=$(awk '/^Name/ {print $2;}' /proc/$proc/status)
            statusProc=$(awk '/^State/ {print $2;}' /proc/$proc/status)
            pidProc=$(awk '/^Pid/ {print $2;}' /proc/$proc/status)

# Calling our function
            compareState $statusProc

# Displaying results with columns
            printf "%-5s | %-15s | %-5s\n" "$pidProc" "$nomProc" "$statusProcV"
        fi 
    }
}

main $@
