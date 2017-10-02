#!/bin/bash

#function ifparam()
#{

if [ $# -eq 1 ] && [ -f $1 ] ;then

	 echo -e "The parameter is a file \n";
 elif
	 [ $# -ge 2 ];then
	 echo "There must only one parameter "
	 exit 0
else
	echo "The parameter is not a file or there is no parameter"
	exit 0

fi

# }

#function boucleinfile()
# {
	while read line
	do
#		echo -e "$line " | awk -F : '{print "Directory: "  $1 "  group or user :  " $2  " Rights:" $3 }'
	pathDir=$(echo -e "$line " | awk -F : '{ print $1 }')
	testGrOrUs=$(echo -e "$line " | awk -F : '{ print $2 }')
	rights=$(echo -e "$line " | awk -F : '{ print $3 }')

	if grep "^$testGrOrUs" /etc/passwd > /dev/null; then
		echo " The user account $testGrOrUs exist "
		echo " The rights of this account $testGrOrUs are $rights "
		setfacl -m u:$testGrOrUs:$rights $pathDir
	else
		echo " The user account $testGrOrUs doesn't exist "
	fi
	
	if grep "^$testGrOrUs" /etc/group > /dev/null; then
		echo " The group $testGrOrUs exist "
		echo -e " The rights of this group $testGrOrUs are $rights \n"
		setfacl -m g:$testGrOrUs:$rights $pathDir

	else
		echo " The group $testGrOrUs doesn't exist "
	fi

	done < $1

#}

# function main ()
# {
#	 ifparam $1
#	 boucleinfile
# }

#main @#
