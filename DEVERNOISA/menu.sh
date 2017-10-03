#!/bin/bash

#Function that allows to check the existence of the informed user
function verifuser()
{
	echo "Verifiation of the user existence. Please enter a username."
	read user
	if  [ `id -u $user 2>/dev/null || echo -l` 2>/dev/null -ge 0 ] 
	then
		echo -e "The user $user exists. \n" 
	else
		echo -e "The user $user does not exists. \n"
	fi
}

#Function that allows to know the UID of the informed user or root by default
function knowuid()
{
	echo -e "View user's UID of $user (root by default) \n"
	id -u $user 	
}

function quit()
{
	echo -e "Quit \n"
}

#Function which permit to print the menu and allows the user to enter a value
function menu()
{
	echo "1 - Verify the existence of a user"
	echo "2 - Know a user's uid"
	echo -e "q - Quit \n"
	echo "Choose an answer :"
	read choice
}

function main() 
{
	#While the value is different from q
	while [ "$choice" != "q" 2>/dev/null ]
	do
		#We display the menu
		menu
		#If the value is equal at 1
		if [ "$choice" -eq "1" 2>/dev/null ]
		then
			#We execute the verifuser function
			verifuser
		#If the value is equal at 2
		elif [ "$choice" -eq "2" 2>/dev/null ]
		then
			#We execute the knowuid function
			knowuid

		fi
	done
	
	#If the value is equal at q
	if [ "$choice"="q" 2>/dev/null ]
	then
		#We execute the quit function and finish the execution of the script
		quit
	fi
}
main
