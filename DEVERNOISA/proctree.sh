#!/bin/bash

function list()
{
	#Verification for the presence of a parameter after the script execution
	if [ $# -eq 0 ]
	then
		echo "Please enter a valid parameter after the script starts"
	else
		#Recuperation of Name, Status, Pid and PPid
		awk '/^State:/ {printf "%-20s",$3}''/^Name:/ {printf "%-20s",$2}''/^Pid:/ {printf "%-20s",$2}''/^PPid:/ {printf "%-20s\n",$2}' /proc/$1/status 2> /dev/null
		#Recuperation of PPid
		child=$(grep "PPid:.*$1" /proc/[0-9]*/status | awk -F '/' '{print $3}')
		[[  -z $2 ]] && printf "Name%15s State%14s Pid%10s PPid%s\n" 
		for value in $child
		do
			list $value 1
		done
	fi
}

function main()
{
	list $1
}
main $@ | sort -k4n
