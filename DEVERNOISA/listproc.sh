#!/bin/bash

function list()
{
	#List all process with regular expression
	list=`ls /proc | grep -E ^[0-9]`

	#Formats column header
	printf "Name%15s State%14s Pid%10s\n"

	for valeur in $list 
	do

		#Recuperation of Name, Status and Pid 
		awk '/^State:/ {gsub("\(|\)","",$3);printf "%-20s",$3}''/^Name:/ {printf "%-20s",$2}''/^Pid:/ {printf "%-20s\n",$2}' /proc/$valeur/status 2> /dev/null

		#Test if process status is a zombie process
		if [ "$2" == "zombie" ]
       		then	
			echo "The process $2 is a zombie process"
			echo "Do you want to remove the zombie process ? (yes/no)"
			read response
			if [ "$response" == "yes"]
			then
				kill -9 $2
			fi	
		fi	
	done
}

function main()
{
	list | sort -k3n 
}
main
