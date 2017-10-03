#!/bin/bash


function menu()
{

echo "1 : Vérifier l'existence d'un utilisateur "
echo " 2 : Connaitre l'UID d'un utilisateur "
echo " q : Quitter "
echo -e "\n Quel est votre choix  = \c ";read reponse
}


function verifuser()
{

echo " Vérifier l'existence d'un utilisateur "
echo -e "\n Saisir le nom du user  = \c ";read user

if grep -q $user /etc/passwd
then
    echo " L'utilisateur $user existe"
 else
 	echo " L 'utilisateur $user non trouvé "
fi
echo
clear
menu
}

function verifuid(){

echo " Vérifier l'UID "
echo -e "\n Saisir le nom du user  = \c ";read ud

if grep -q $ud /etc/passwd
then
    echo " L'uid  existe"
 else
             echo " L 'utilisateur $user non trouvé "
 fi
 echo
 clear 
 menu

}



function main()
{

menu
case $reponse in
 1)	
	verifuser 
  		
;;
2) 
	verifuid
;;

q)
	echo "Au revoir"
;;
*)
	menu
	
esac


}



main $@
exit 0

