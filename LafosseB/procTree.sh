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

# Testing if a key already exists in our hash table
function array_key_exists() {
    local _array_name="$1"
    local _key="$2"
    local _cmd='echo ${!'$_array_name'[@]}'
    local _array_keys=($(eval $_cmd))
    local _key_exists=$(echo " ${_array_keys[@]} " | grep " $_key " &>/dev/null; echo $?)
    [[ "$_key_exists" = "0" ]] && return 0 || return 1
}

# Testing if the user gave a write parametter
    if [ $# -gt 1 ]
    then
        echo "Please provide only one or no parameter to check"
    else
        if [ $# -eq 0 ]
        then
            echo "No parameter given -> show all processes..."
            processList=$(ls /proc | grep -e ^[0-9] | sort -n)
            for process in $processList;
            do
# Fetching the required elements
                pidProc=$(awk '/^Pid/ {print $2;}' /proc/$process/status 2> /dev/null)
                ppidProc=$(awk '/^PPid/ {print $2;}' /proc/$process/status 2> /dev/null)

# Creating new hash table
                declare -A processArray

                #if [ $ppidProc in processArray ]
                #then
                #    echo "La clé est présente"
                #else
                #    echo "La clé n'est pas présente"
                #fi
                if [[ "$(array_key_exists 'processArray' $ppidProc; echo $?)" = "0" ]]; then
                    #echo "Adding ID $pidProc to the hash table"
                    processArray[$ppidProc]+=",$pidProc" 
                else
                    if [ ! -z "$ppidProc" ] 
                    then
                        #echo "Creating new key with ID $ppidProc"
                        processArray[$ppidProc]="$pidProc"
                    fi
                fi

                #echo "$process"
                #getChildPID $process
            done
        else
            echo "Showing children of the PID -> $1"
            getChildPID $1
        fi
    fi

# Formatting the display of our result
    for i in "${!processArray[@]}"
    do
        echo "$i"
        echo "    :${processArray[$i]}"
    done
}

main $@
