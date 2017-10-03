#!/bin/bash

function menu(){
 
	while [ "$param" != "q" ]
	do
		read -p "Veuillez choisir l'information que vous souhaitez
			1 - Vérifier l'existence d'un utilisateur
			2 - Connaitre l'UID d'un utilisateur
			q - Quitter
					Votre choix : " param

		case "$param" in
			1) userExist;;
			2) userUID;;
			q)echo "Au revoir"
				exit;;
			*)echo "Je n'ai pas compris votre demande. Veuillez entrer une donnée valide"
				read -p "Appuyer sur une touche pour revenir au menu" -n 1
				clear
				menu;;
		esac
	done	
}



function userExist(){
	
	read -p "Vérifier l'existence de l'utilisateur : " eUser
	
	if grep -q "$eUser:" /etc/passwd
	then
		echo "L'utilisateur $eUser existe"

	else

		echo "L'utilisateur $eUser n'existe pas"

	fi
	
	read -p "Appuyer sur une touche pour revenir au menu" -n 1
	clear
	menu
	
}

function userUID(){
	
	read -p "Avoir l'UID de l'utilisateur : " uUser
	
	if grep -q "$uUser:" /etc/passwd
	then
		uid=$(id -u "$uUser")
		echo "L'UID de l'utilisateur $uUser est $uid"

	else

		echo "L'utilisateur n'est pas existant"

	fi	
	
	read -p "Appuyer sur une touche pour revenir au menu" -n 1
	clear
	menu	

}


function main(){
	menu

}

main $@
