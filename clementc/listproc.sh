#!/bin/bash

#This script allow you to list every enabled process

replist=`ls /proc | grep -E ^[0-9]`

for rep in $replist
do
	printf "%s `grep "Name" /proc/$rep/status`\n"
	printf "%s `grep "^Pid" /proc/$rep/status`\n"
	printf "%s `grep "State" /proc/$rep/status`\n"

	printf "%s \n"
done


