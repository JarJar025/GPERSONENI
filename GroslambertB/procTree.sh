#! /bin/bash

#dody of the program
function getProccess()
{
	rm tempo 2> /dev/null
	rm fileSortProc 2> /dev/null
	
	# get PID number in var lesPid
	lesPid=$(ls /proc | grep -E ^[0-9])
	#printf "%-20s" PID PPID Name Statu >>tempo
	#printf "\n\r">>tempo

	#loop "for": displays on the standard input the name of the processes in operation, the PID and the statuses. Redirects errors to black hole
	for lePid in $lesPid; do
		ligneProc=$(awk '/^Pid/{printf "%-20d",$2 } /^PPid/{printf "%-20d\n",$2} /^State/{gsub("\(|\)","",$3); printf "%-20s",$3} /^Name/{printf "%-20s",$2}' /proc/$lePid/status 2> /dev/null)
		echo $ligneProc | awk '{printf "%-20d %-20d %-20s %-20s\n", $3,$4,$1,$2}' >>tempo
	done
	tmp=tempo
	sort -n -k 1 $tmp >>fileSortProc
#nous avons réfléchi en classe entière pour trouver une solution pour la trie par PID et avec le processus père Il nous a fallu beaucoup de temps pour trouver une piste solide. nous continuerons le reste du script lors du TP de mercredi
# voici notre réffexion 

#Sort the PID by PPID like a tree, with the whole class we think about do that

#For each PID
	#Get PPID and PID
		#If PPID exists in tab[]
			#Create tab[PPID]
		#Else
			#Add PID in tab[PPID]
		#Fi
#done

#And we loop on the table tab[] to print the results

		
}


function main()
{
getProccess
}
main $@
