#!/bin/bash

#This script allow you to list every enabled process
#listed by Name, Pid, and State

#ALPHA VERSION

#TEMPORARY CODE
#process=$(awk '/^Pid|State|Name/ {printf "%-25s%25s%25s "%s "$2 "$3}' /proc/$rep/status)

printf "\n%-25s%25s%25s\n" **Name** **Pid** **State**

function new_ps()
{
	processus_rep=`ls /proc | grep -E ^[0-9]`
	
	for rep in $processus_rep
	do
		if [ -e /proc/$rep/status ] 
		then
			process=$(awk '/^Pid|^Name/ {printf "%s ",$2} /^State/ {gsub("\(sleeping\)","SLEEPING", $3); printf "%s ",$3}' /proc/$rep/status)
#			process=$(awk '/^Pid|State|Name/ {print $2 $3}' /proc/$rep/status)
			echo $process
#			name=`grep -s "Name" /proc/$rep/status | awk '{print $NF}'`
#			pid=`grep -s "^Pid" /proc/$rep/status | awk '{print NF}'`
#			state=`grep -s "State" /proc/$rep/status | awk '{print $2 $3}'`
#			printf "%-25s%25s%25s\n "$name "$pid "$state
		fi
	done
}

function main()
{
	new_ps
}

main
