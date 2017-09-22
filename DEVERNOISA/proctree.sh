#!/bin/bash

#Sort the PID by PPID like a tree with the whole class we think about do that

#For each PID
#Do
	#Get PPID and PID
		#If PPID exists in tab[]
			#create tab[PPID]
		#Else
			#Add PID in tab[PPID]
		#FI
#Done

#And we loop on the table tab[] to print the results


function list()
{
	#List all process with regular expression
	list=`ls /proc | grep -E ^[0-9]`

	#Formats column header
	printf "Pid\n"

	for valeur in $list 
	do

		#Recuperation of Pid 
		pid=$(awk '/^Pid/ {print $2}' /proc/$valeur/status 2> /dev/null)
		echo $pid
	done
}

function main()
{
	list | sort -n
}
main

