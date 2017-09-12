#!/bin/bash

#This script allow you to list process with their name PID and State


listProc=`ls /proc | grep -E ^[0-9]`

#This fucntion get the name, status and PID of the processes
function getprocess()
{
for proc in $listProc
do
	printf "%s `grep "Name" /proc/$proc/status`\n"
	printf "%s `grep "^Pid" /proc/$proc/status`\n"
	printf "%s `grep "State" /proc/$proc/status`\n"

	printf "%s \n"
done
}

function main()
{
getprocess
}

main $@
