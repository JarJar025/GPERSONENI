#!/bin/bash

#The aim of this script is to retrieve the name, the pid and the status of various processes

#This variable contains a list of pid for each process located in /proc
#repBoucle=`ls /proc | grep -E ^[0-9]`

#Recuperation du numéro de processus

function numprocess (){
read -p "Enter a process number:" numproc
 
	if [ -e /proc/$numproc/status ]
	then
		awk '/^Name/{printf "\n%-20s",$2}/^State/{gsub("\(|\)"," ",$3);printf "%20s",$3}/^Pid/{printf "%20s",$2}/PPid/{printf "%20s\n",$2}' /proc/$numproc/status 2> /dev/null
		child=$(grep "^PPid:.*$numproc" /proc/[0-9]*/status | awk -F '/' '{print $3}')
		printf "Les processus enfants du processus père numéro $numproc sont \n $child \n"

			 
	fi

#function folderBoucle (){
#for fold in $repBoucle
#do
	#test if the status's file exists for each PID's folder 
#	if [ -e /proc/$fold/status ]
#		then
#			awk '/^Name/{printf "\n%-20s",$2}/^State/{gsub("\(|\)"," ",$3);printf "%20s",$3}/^Pid/{printf "%20s\n",$2}' /proc/$fold/status
			 
#	fi
#done

}

function main ()
#Call of the FolderBoucle 's function 
{
#folderBoucle | sort -k3n #sort the  third column
numprocess
}
main $@
