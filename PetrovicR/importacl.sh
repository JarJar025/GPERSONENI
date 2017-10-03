#!/bin/bash 

function user()
{
	#If the  user exist
	if [ `id -u $user 2>/dev/null || echo -l` 2>/dev/null -ge 0 ]
	then
		#Display  user information
		echo "The user account $user exists"
		#Call the right function
		right
	else 
		#Else create the user 
		echo "The user account $user will be created"
		useradd "$user" 2> /dev/null 
		#Call the right function
		right
	fi
}

function right()
{
	#Defined the owner of the directory
	chown $user $path
	#Assign the user's rights to the directory
	setfacl -m u:$user:$right $path
	echo "Here are the user rights applied $right"
}

function main()
{
#Reads the file and cuts it as variables path, user and rights
while IFS=':' read path user right
do
	echo "$path $user $right"
	#If the recovered path exits
	if [ -d $path ]
	then
		#Display it
		echo "The directory $path exists"
		#Call the user function
		user
	else
		#Esle create it
		mkdir $path
		#Call the user function
		user
	fi
done < $1
}

main $@
