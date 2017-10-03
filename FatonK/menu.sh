#!/bin/bash

#This script checks if a users exists and knows its UID

#This function checks if a users exists

function getusers()
{
	until grep -qw "^$user" /etc/passwd; 
	do 
		printf "which user would you like to check ? "; 
		read user; 
	done; 
		printf "The user $user exists \n"	
}

function getuid()
{
	read -p "enter a username : " user;
	uid=$(grep $user /etc/passwd | cut -d: -f3)
	printf "The UID for the user $user is $uid \n" 
}
function main ()
{
	getusers
	getuid
}
main $@
