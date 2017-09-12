#!/bin/bash

#This script allow you to list process with their name PID and State


listProc=`ls /proc | grep -E ^[0-9]`

#This fucntion get the name, status and PID of the processes
function getprocess()
{
for proc in $listProc
do

	awk '/^Name/ {printf "\n%-20s", $2} /^State/ {gsub("\(|\)"," ",$3); printf "%20s",  $3} /^Pid/ {printf "%20s \n", $2}' /proc/$proc/status

done
}

function main()
{
getprocess
}

main $@
