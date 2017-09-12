#!/bin/bash
#This script is similar to ps,its give just a name, status 
#and pid number of processus

#listerep is a variable which contains a list of pid of
#each processus located in /proc 
listerep=`ls /proc | grep -E ^[0-9]`

function affiche()
{
printf "\n%-20s %20s %20s\n" Nom       Statut    PID
for rep in $listerep
do	
	if [ -d /proc/$rep ]
	then
		nom=`egrep "Name" /proc/$rep/status | awk -F":" '{print $2}' `
		state=`egrep  "State" /proc/$rep/status | awk -F":" '{print $2}' ` 
		pid=`egrep -E ^Pid /proc/$rep/status | awk -F":" '{print $2}'`
		printf "%-20s %20s %20d\n"$nom "$state" $pid 
	fi
	
done

}	


affiche
exit 0
