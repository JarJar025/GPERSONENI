#!/bin/bash

#Get folder in /proc for all processus
function getFolderProc(){

	pathProc=`ls /proc | grep -s -E ^[0-9]`

}

#Get processus name and status
function getNameStatusProc(){

	#Call of the function that get the processus
	getFolderProc

	#Action for each processus folder
	for folder in $pathProc
	do
		#Check if the folder is not empty
		if `grep -s -v -q 'Name' /proc/$folder/status`
		then
			nameProc=`grep -s 'Name' /proc/$folder/status | awk '{print $2}'`
			pidProc=`grep -s '^Pid' /proc/$folder/status | awk '{print $2}'`
			statProc=`grep -s 'State' /proc/$folder/status | awk '{print $2}'`		

			#Call for the function that verbose the status
			changeStatName

			printf "The processus $nameProc, with the id $pidProc has the status $newStateProc.\n"

		else
			#Error message if the folder is empty
			printf "/proc/$folder is an empty, illisible or inexisting folder.\n"
		fi

	done
	
}

#Change the status name
function changeStatName(){

	#List of all possible status and change in a sentence easier to understand
	case $statProc in
		R) newStateProc="running";;
		S) newStateProc="sleeping in an interruptible wait";;
		D) newStateProc="waiting in uninterruptible disk sleep";;
		Z) newStateProc="zombie";;
		T) newStateProc="stopped on a signal";;
		W) newStateProc="swapped";;
		*) newStateProc="unknown status"
	esac

}

#Main function
function main(){
	
	getNameStatusProc
	
}

#Call of the main function
main $@

