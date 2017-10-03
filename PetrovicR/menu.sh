#!/bin/bash 
function user()
{
	#If the  user exist
	if [ `id -u $1 2>/dev/null || echo -l` 2>/dev/null -ge 0 ]
	then
		#Display  user information
		echo "The user account $1 exists"
		#give UID user
		uidUser=$(awk -F":" '/^'$1'/ {print $3};' /etc/passwd)
		 #uidUser=`grep $1 /etc/passwd | cut -d: -f3`
		echo " l'UID de $1 est $uidUser"
	else
		exit
	fi

}

function main()
{
  user $1
}
main $@
