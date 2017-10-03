#!/bin/bash

#This script allow you to list process ans their children with their PID, Name and Status
function listproc () {

read -p "Enter a process number : " num

	child=$(grep "^PPid:.*$num" /proc/*/status | awk -F '/' '{print $3}')
	printf "$child \n"
}

function main()
{
	listproc | sort -n

}
main $@
