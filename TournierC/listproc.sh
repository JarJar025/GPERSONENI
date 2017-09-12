#!/bin/bash

#This script allow you to list every enabled process
#listed by Name, Pid, and State

#ALPHA VERSION

processus_rep=`ls /proc | grep -E ^[0-9]`

printf "\n%-25s%25s%25s\n" **Name** **Pid** **State**

function new_ps()
{
for rep in $processus_rep
do
	name=`egrep "Name" /proc/$rep/status | awk '{print $NF}'`
	pid=`egrep "^Pid" /proc/$rep/status | awk '{print NF}'`
	state=`egrep "State" /proc/$rep/status | awk '{print $2 $3}'`
#	printf "%s \n"
	printf "%-25s%25d%25s\n "$name "$pid "$state

done
}

function main()
{
	new_ps
}


main
