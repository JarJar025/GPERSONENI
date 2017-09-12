#!/bin/bash

function list()
{
	#récupérer liste des processus selon les PID
	list=`ls /proc | grep -E ^[0-9]`

	#boucle qui va afficher tous les noms, prénoms et PID des processus de la liste
	for valeur in $list 
	do
		
		#afficher le nom, l'état et le PID
		awk '/^State:/ {gsub("\(|\)","",$3);printf "Statut:%-19s",$3}''/^Name:/ {printf "Nom:%-20s",$2}''/^Pid:/ {printf "Identifiant:%-18s\n",$2}' /proc/$valeur/status 2> /dev/null
	done
}
list
