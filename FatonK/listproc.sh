#!/bin/bash

#This script allow you to list process with their name PID and State

#This fucntion get the name, status and PID of the processes
function getprocess()
{	printf "%s"
	printf "%-20s" Name Status PID
	printf "\n"
	listProc=`ls /proc | grep -E ^[0-9]`

		for proc in $listProc
		do
			awk '/^Name/ {printf "%-20s", $2} /^State/ {gsub("\(|\)","",$3); printf "%-20s",  $3} /^Pid/  {printf "%-20d \n", $2}' /proc/$proc/status 2> /dev/null
		done
}

function main()
{
	getprocess | sort -k3n
}
main $@
