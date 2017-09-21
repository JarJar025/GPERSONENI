#!/bin/bash


function createUser()
{
echo -e "Saisissez un nom d'utilisateur : "
read user 

	if  grep "^$user" /etc/passwd ;then
		echo "l'utilisateur $user existe"
		echo " L'UID de l'utilisateur $user est : "
		more /etc/passwd | grep $user | awk -F ":" '{print $3}'
	else
		echo  "L'utilisateur $user nexiste pas"
	fi
}

function exitFunc()
{
echo -e " Pour quitter le menu appuyer sur [q]"
read choix
	if [ $choix == q ];then
		echo "Vous avez quitté le menu"
		clear
		exit 0
	else
		createUser
	fi
}


function main ()
{
	createUser
	exitFunc
}
main @#

