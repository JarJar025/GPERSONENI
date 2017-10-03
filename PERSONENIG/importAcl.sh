#!/bin/bash

#Get the path of the file by parameter
function getPathByParam(){
	
	if [ "$#" -eq 1 ]
	then

		if [ -f "$1" ]
		then
			pathFile="$1"

	else

			echo "Le chemin entré n'est pas valide"
			getPathByReadCommand
		fi

	else
		getPathByReadCommand

	fi

}

#Get the path of the file by read command
function getPathByReadCommand(){

	until [ -f "$pathFile" ]
	do
		read -p "Veuillez entrer le chemin ABSOLU de votre fichier : " pathFile
	done
}

function setAcl(){

	directory=$(awk -F ":" '{ printf"%s\n",$1 }' $pathFile)
	targets=$(awk -F ":" '{ printf"%s\n",  $2 }' $pathFile)
	rights=$(awk -F ":" '{ printf"%s\n",  $3 }' $pathFile)
	nbLines=$(awk 'END {print NR}' $pathFile)

	#Check if the directory exists
	for dir in $directory
	do
		if [ ! -d $dir ]
		then
			mkdir $dir
		fi
		
		#Table with all directory
		tabDir+=("$dir")
	done	

	#Check if the target is an user or a group
	#If the target doesn't exist so we add an user account
	for target in $targets
	do
		if grep -q "$target:" /etc/passwd 
		then
			#Table with all targets
			tabTarg+=("$target")
			#Table with the property (user or group) with the same index than the corresponding target
			tabUsrGrp+=("user")

		elif grep -q "$target:" /etc/group 
		then
			tabTarg+=("$target")
			tabUsrGrp+=("group")
		
		else
			$(useradd $target )
			tabTarg+=("$target")
			tabUsrGrp+=("user")
		
		fi
	done

	#Check if the asked rights are valid
	for right in $rights
	do
		if [[ $right =~ [r-]?[w-]?[x-]? ]]
		then
			#Table with all the rights
			tabRight+=("$right")
		fi

	done

	for (( i=0; i < $nbLines; i++ ))
	do
		
		if [ "${tabUsrGrp[$i]}" = "user" ]
		then
			#Set acl for the user and the group 
			setfacl -m u:"${tabTarg[$i]}":"${tabRight[$i]}" "${tabDir[$i]}"
			setfacl -m g:"${tabTarg[$i]}":"${tabRight[$i]}" "${tabDir[$i]}"
			echo "Les droits ${tabRight[$i]} ont été attribué sur ${tabDir[$i]} à l'utilisateur et au groupe ${tabTarg[$i]}"
		
		else
			#Set acl for the group
			setfacl -m g:"${tabTarg[$i]}":"${tabRight[$i]}" "${tabDir[$i]}"
			echo "Les droits ${tabRight[$i]} ont été attribué sur ${tabDir[$i]} au groupe ${tabTarg[$i]}"
		
		fi

	done

}




function main(){
	
	getPathByParam $1
	setAcl

}

main $@
