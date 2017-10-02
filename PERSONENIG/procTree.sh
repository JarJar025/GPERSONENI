#!/bin/bash

function getNumProcByParam(){
	
	printf "/!\ Attention tous les fichiers dont le nom correspond à children*.txt seront supprimés à la fin du script /!\ \n"

	if [ "$#" -eq 1 ]
	then
		
		if [ "$(echo $1 | grep "^[[:digit:]]*$")" ]
		then
			num=$1
		
			if [ ! -e /proc/$num/ ]
			then
				echo "Le processus $num n'existe pas."
				getNumProcByReadCommand
			fi
	
		else
			echo "Le paramètre entré n'est pas un chiffre"
			getNumProcByReadCommand
		fi
					
	else
		getNumProcByReadCommand
	fi	
	
	level=0

	if [ $num -eq "0" ]
	then
		echo "Seul 1 est un enfant de 0" 
		num=1
	fi

}

function getNumProcByReadCommand(){

	#Get the parent process the user want	
	read -p "Veuillez entrer le numéro de processus à partir duquel vous voulez commencez l'arbre : " num

}

#Use for shifting processes following their level
function showLevel(){
	
	showlevel=""
	for ((i=1; i<=$level; i++))
	do
		showlevel+="----"
	done
}

function getProcTree(){
	
	#Check if the process folder exists
	if [ -e /proc/$num/status ]
	then
		
		#Get Pid, status and name of status
		propProc=$(awk '/^Pid/ {print $2} /^Name/ {print $2} /^State/ {print $3}' /proc/$num/status)
			
		showProc=$(echo $propProc | awk '{printf "%-20d %-20s %-20s\n " ,$3,$1,$2}')

		#Show the process prop and its level
		echo $showlevel$showProc
		
		#Get the children of the current process and redirect in a file
		#Regex match only with the $num value
		grep "PPid:[[:space:]]*$num[[:space:]]*" /proc/[0-9]*/status | awk -F '/' '{printf "%-20d \n", $3}' > children$num.txt
          
			#If the file is not empty		
			if [ -s "children$num.txt" ]
			then
				
				((level++))

				children=$(cat children$num.txt | sort -n)	
								
					#For each processes in the file	
					for child in $children
					do
						#Call of the showLevel function
						showLevel	

						#the current process change
						num=$child
		
						getProcTree $num

					done
			
			else
				level=1			
			fi
		
	else
		
		2>/dev/null
	
	fi	

}


#Main function
function main(){
	
	getNumProcByParam $1
	getProcTree

	#Delete all files created
	rm children*.txt

}

#Call of the main function
main $@



