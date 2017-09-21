#! /bin/bash


function menu()
{
	#we initalize our loop so that it executes at least once
	commande="0"
	#while loop to display the loop menu
	while [ $commande != "q" ]
	do
	
	echo 'Bienvenue dans la fontion menu.sh'
	echo 'Voici les commande disponible:'
	echo '1 - Vérifier l existance d un user'
	echo '2 - Connaitre l UID d un user'
	echo 'q - quitter '
	read commande
	clear
	
	#it is displayed if the user exists	
	if [ $commande = "1" ]
	then	
		echo "saisire le nom du user:"
		read userSerch
		listUser=$(cat /etc/passwd | awk -F: '{print $ 1}')
		testUser=0
        	for user in $listUser
        	do
		
                	if [ user = "$userSerch" ]
			then
				testUser=1
				#echo "$userSerch existe"
                	fi
        	done
		if [ $testUser -eq 1 ]
		then
			echo "$userSerch exist"
		else
			echo "$userSerch exist pas"
		fi
	elif
	#we leave the program 
	[ $commande = "q" ]
	then
		exit 0
	elif	
	#we display the UID of the user
	[ $commande = "2" ]
	then
	echo "saisir le nom du user:"
	read userUID
	echo `grep $userUID /etc/passwd | cut -d: -f3`
	

	fi
	done		
}




#dody of the program
function main()
{

	menu

}
main $@
