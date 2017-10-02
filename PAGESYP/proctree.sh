#!/bin/bash

#The aim of this script is to retrieve the child of PPID.

#Display the children Processes  of a PPID

function childrenProcess (){

read -p "Enter a process number:" numproc
 
	if [ -e /proc/$numproc/status ];then
		awk '/^Name/{printf "\n%-20s",$2}/^State/{gsub("\(|\)"," ",$3);printf "%20s",$3}/^Pid/{printf "%20s",$2}/PPid/{printf "%20s\n",$2}' /proc/$numproc/status 2> /dev/null
		child=$(grep "^PPid:.*$numproc" /proc/[0-9]*/status | awk -F '/' '{print $3}')
		printf "The children processes of PPID  $numproc are \n $child \n"

			 
	fi

}

function main ()
#Call of the childrenProcess 's function 
{
childrenProcess
}
main $@
