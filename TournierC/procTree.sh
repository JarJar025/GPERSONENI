#!/bin/bash

#This script is like the "ps" command but it allow you to list every processus childrens of aparent processus

function sons()
{
echo "Please, what it your process number ?"
read answer
	if [ ! -e /proc/$answer/status ];	
		then 
			printf "Processus not found.\n"
		else
			awk '/^Pid|^Name|^PPid/ {printf "%s ",$2} /^State/ {printf "%s ",$3}' /proc/$answer/status 2> /dev/null #Show the selected process informations
			local sons=$(grep "^PPid:.*$answer$" /proc/[0-9]*/status | awk -F '/' '{print $3}' | sort -n | uniq) #Listing of every childrens	
			printf "\nChildrens are :\n$sons" #Display
#		elif	[ -z "$sons" ] 
#			then #if the processus has no children
#				printf "\nThis processus has no children.\n"
	fi
}

function main()
{
sons
}

main
