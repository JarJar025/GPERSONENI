#!/bin/bash

#This script allow you to list process with their name PID and State


lastproc=`ls /proc | grep -E ^[0-9]`
function Main()
{
}

#This fucntion get the name, status and PID of the processes
function getProcess()
{
for proc in $lastproc
do
	printf "%s `grep "Name" /proc/$proc/status`\n"
	printf "%s `grep "^Pid" /proc/$proc/status`\n"
	printf "%s `grep "State" /proc/$proc/status`\n"

	printf "%s \n"
done
}

getProcess
