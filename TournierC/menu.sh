#!/bin/bash
#This script allow you to check if a user exist on the current system or not and it will display his User ID.

function user_check()
{
	clear
	read -p "Please enter a username to check if it exist on the current system : " user
	if id "$user" &>/dev/null
		then
			echo "This user exist."
		else
			echo "User not found."
	fi
	echo `id $user | awk '{printf "%s ",$1}' 2> /dev/null`
}

function main ()
{
	
	user_check
}

main
