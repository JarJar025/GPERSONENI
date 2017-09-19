#!/bin/bash

#This script allow you to list every enabled process
#listed by Pid, Name, and State

#ALPHA VERSION

printf "\n%-20s %-20s %-20s %-20s\n" **PID** **NAME** **STATE** **KB_MEM**

function new_ps()
{
	local processus_rep=`ls /proc | grep -E ^[0-9]`
	
	for rep in $processus_rep
	do
		if [ -e /proc/$rep/status ] 
		then
			local process=$(awk '/^Pid|^Name|^VmRSS/ {printf "%s ",$2} /^State/ {gsub("\(sleeping\)","SLEEPING", $3); printf "%s ",$3}' /proc/$rep/status)
			echo $process | awk '{printf "%-20d %-20s %-20s %-20d\n",$3,$1,$2,$4}' >> /tmp/test_listproc.txt 	

#			name=`grep -s "Name" /proc/$rep/status | awk '{print $NF}'`
#			pid=`grep -s "^Pid" /proc/$rep/status | awk '{print NF}'`
#			state=`grep -s "State" /proc/$rep/status | awk '{print $2 $3}'`
#			printf "%-25s%25s%25s\n "$name "$pid "$state
		fi
	done
	cat /tmp/test_listproc.txt | sort -nk 1
	rm /tmp/test_listproc.txt
}

#function kill_ps()
#{
	
#}

function main()
{
	new_ps
}

main
