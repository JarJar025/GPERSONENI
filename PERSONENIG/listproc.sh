#!/bin/bash

#Get folder in /proc for all processus
function getFolderProc(){

	pathProc=`ls /proc | grep -s -E ^[0-9]`
	
}

#Get processus name and status
function getNameStatusProc(){

	#Call of the function that get the processus
	getFolderProc

	#Write in the console
	printf "%-20s" PID	Name	Status
	printf "\n\r"

	#Action for each processus folder
	for folder in $pathProc
	do
		
		#Check if the folder exists
		if [ -e /proc/$folder/status ]
		then
			#Get Pid, status and name of status
			propProc=$(awk '/^Pid/ {print $2} /^Name/ {print $2} /^State/ {gsub("\(|\)"," ",$3); print $3}' /proc/$folder/status)
		
			#Check if the proc is a zombie	
			#if [ awk '{print $1 }'== "zombie" ]
				
			#	echo $propProc | awk '{printf "%-20d %-20s %-20s\n z ", $3,$2,$1}' | "sort -n -k 1"	
	#		fi	
			
			#Show PID Name and State
			echo $propProc | awk '{printf "%-20d %-20s %-20s\n ", $3,$1,$2}' 
      
	#sort -n -k 1	

		else
			#if the folder is empty redirect errors to /dev/null
			2> /dev/null
			
		fi

	done
	
}


#Main function
function main(){
	
	getNameStatusProc
	
}

#Call of the main function
main $@

