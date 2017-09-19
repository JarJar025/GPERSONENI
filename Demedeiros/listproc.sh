#!/bin/bash
#This script is similar to ps,its give just a name, status 
#and pid number of processus


#this file contains the list of process ID 
file_proc="/tmp/proc"
[ -e $file_proc ] && rm $file_proc

#This files contains the lists of process ID sort by PID
file_proc_sort="/tmp/proc_sort"
[ -e $file_proc_sort ] && rm $file_proc_sort

function search()
{

#listerep is a variable which contains a list of pid of
#each processus located in /proc 
local listerep=`ls /proc | grep -E ^[0-9]`


	for rep in $listerep
	do
		if [ -e /proc/$rep/status ]
			then
			string_pid_ppid_status_name=$(awk '/^Pid/ {print $2 } /^PPid/ {print $2}/^Name/ {print $2} /^State/ {print toupper(substr($3,2,length($3)-2))}'  /proc/$rep/status ) 
			echo $string_pid_ppid_status_name | awk '{printf "%-20d %-20d %-20s %-20s\n",$3,$4,$2,$1}' >> $file_proc
		fi
	done

	#sort by the first column ( PID )
	sort -n -k 1 $file_proc >> $file_proc_sort
	
}



#this function detect zombie process on a given file which contains
#list of process 
#param $1 : $file_proc
function findzombie()
{
	if [ -e "$1" ]
	then

		 printf " %-20s %-20s %-20s %-20s\n" "Pid" "PPid" "STATUT" "NOM" 
		#awk '/ZOMBIE/ {printf "%s\n", $0 }' "$1"
		grep "ZOMBIE" $1
		return_code=$?
		
		if [ $return_code -eq 0 ]
		then
			printf " \nProcessus zombies trouvés " 
	 		printf "\n%sQuel processus souhaiteriez-vous mettre fin ?"
			echo -e "\n Saisir le PID du processus = \c ";read pid_answer
			#test if $pid_answer is empty
			[ -z $pid_answer ] && printf " Abandon du script, paramètre absent\n " && exit 1
			#test if $pid_answer is an integer
			if ((pid_answer)) 2> /dev/null
			then
				kill $pid_answer
				return_code=$?
				[ $return_code -eq 0 ] && printf " Commande Kill %d réussi\n" $pid_answer 
			else
				printf " Saisir une valeur entière pour le PID "
				exit 1
			fi
		fi

		return ${return_code}
	else
		printf " $1 n'existe pas "
		return 2
	fi

}



function main()
{
	search
	printf "%s\n-----------------------------------------------------------------------------------------------------"
	printf "\n  Ceci est une simulation d'exemple de processus Zombie"
	printf "\n   1 - Ouvrir deux terminaux "
	printf "\n   1 - Exécuter le script simulation_zombie pour créer des processus zombies  (dans le terminal 1) )"
	printf "\n       Ils seront automatiquement détruits par le père à la fin de l'exécution"
	printf "\n   2 - Executer le script listproc.sh pour l'analyse des processus "
	printf "\n  Conseil : Saisir le PID du processus père pour mettre fin au(x) fils\n"
	printf "%s\n-----------------------------------------------------------------------------------------------------\n\n"
	findzombie "$file_proc_sort"
		
}




main $@
exit 0












