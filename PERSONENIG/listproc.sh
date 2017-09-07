#!/bin/bash

#Get folder for all processus
function getFolderProc(){

pathproc=`ls /proc | grep -E ^[0-9]`

}

#Get processus name and status
function getNameStatusProc(){

	for folder in $pathproc
	do
		printf "`grep 'Name' /proc/$folder/status`"
		printf "`grep '^Pid' /proc/$folder/status`"
		printf "`grep 'State' /proc/$folder/status`"		

	done
}


#Main function
function main(){

	getFolderProc
	getNameStatusProc

}

main $@

