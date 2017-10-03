#!/bin/bash

#This script allow you to list every enabled process
#listed by Pid, Name, and State

#ALPHA VERSION

printf "\n%-20s %-20s %-20s %-20s %-20s\n" **PID** **PPid** **NAME** **STATE**

function new_ps()
{
	local processus_rep=`ls /proc | grep -E ^[0-9]`
	
	for rep in $processus_rep
	do
		if [ -e /proc/$rep/status ] 
		then
			local process=$(mawk '/^Pid|^Name|^PPid/ {printf "%s ",$2} /^State/ {gsub("\(sleeping\)","SLEEPING", $3); printf "%s ",$3}' /proc/$rep/status)
			echo $process | awk '{printf "%-20d %-20d %-20s %-20s\n",$3,$4,$1,$2}' >> /tmp/test_listproc.txt 	
		fi
	done 

	cat /tmp/test_listproc.txt | sort -nk 1
	rm /tmp/test_listproc.txt
}

#	for childs in /proc/*/status

function main()
{
	new_ps
}

main
