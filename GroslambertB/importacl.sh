#! /bin/bash


#function creatAclWithParam() 
#{
#	#script call    ./importacl.sh /path/path:nameuser:RWX
#	param=$@
#        param1=$(echo $test | cut -f1 -d:)
#        param2=$(echo $test | cut -f2 -d:)
#        param3=$(echo $test | cut -f3 -d:)

#        listUser=$(cat /etc/passwd | awk -F: '{print $ 1}')
#        for user in $listUser; do
#                if [ user = $param2 ]
#                setfacl -Rm u:$param2:$param3 $param1
#                #setfacl -Rm u:khadija:rw /var/www
#                fi
#        done
#
#        listGroup=$(cat /etc/group | awk -F: '{print $ 1}')
#        for group in $listGroup; do
#                if [ group = $param2 ]
#                setfacl -Rm g:$param2:$param3 $param1
#                fi
#        done
#}


function existParam()
{
#this function will check that the parameter is present, that there is only one and that it is a file
	if [ $# -eq 1 ] && [ -f $1 ]
	then
		echo -e "OK Parameter is a file \n";
 	elif
		[ $# -ge 2 ];then
		echo "There must only one parameter "
		exit 0
	else
        	echo "Error of parameter"
		echo "Pleas tack juste one file in parameter who containt list /path:userOrGroup:rwx"
		exit 0

	fi

}


function creatAcl()
{

	while read line
        do
		#recovery of the different data in the impotation file
        	local path=$(echo -e "$line " | awk -F : '{ print $1 }')
        	local userGroup=$(echo -e "$line " | awk -F : '{ print $2 }')
        	local rights=$(echo -e "$line " | awk -F : '{ print $3 }')
		echo $path
		echo $userGroup
		echo $rights
		# creating folder if dosn t exist
		if [ ! -d "$path" ];then
			echo "existe pas"
			mkdir $path
		else
			echo "exiqte déja"
		fi

        	#If user exist continu creating ACL process
		if grep "^$userGroup" /etc/passwd > /dev/null
		then
			#if user exist -> creat ACL
                	setfacl -m u:$userGroup:$rights $path 2>/dev/null
			local res=$?
                        if [ $res -eq 0 ] #Command Success Test
                        then	
				#if the command did not return error
                        	echo "acl user:$userGroup path:$path rights:$rights creat"
                        else
				#If cmmand return error
                        	echo "error acl not creat"
                        fi
        	else	
		#else user dosnt existe creat or no.
                	echo " The user account $userGroup doesn't exist, do you want creat? y/n"

			read creatUser
        		if [ "$creatUser" = "y" ]
        		then
				#creating user + ACL
				useradd $userGroup
				setfacl -m u:$userGroup:$rights $path 2>/dev/null
                        	local res=$?
                                if [ $res -eq 0 ] #Command Success Test
                                then
					#if the command did not return error
                                        echo "acl user:$userGroup path:$path rights:$rights creat"
                                else
					#If cmmand return error
                                        echo "error acl not creat"
                                fi
			fi
        	fi
		
		#If groupe exist continu creating ACL process
		if grep "^$userGroup" /etc/group > /dev/null
		then
                	setfacl -m g:$userGroup:$rights $path 2>/dev/null
			local res=$?
                        if [ $res -eq 0 ] #Command Success Test
                        then
				#if the command did not return error
                                echo "acl user:$userGroup path:$path rights:$rights creat"
                        else
				#If cmmand return error
                                echo "error acl not creat"
                        fi

        	else
		#If groupe dosn t exist creat groupe + continu creating ACL process
                	echo " The group $userGroup doesn't exist, do you want creat? y/n "
			read doYouWantCraetGroup
                        if [ "$doYouWantCraetGroup" = "y" ]
                        then
				#creating user + ACL
                                groupadd $userGroup
                                setfacl -m u:$userGroup:$rights $path 2>/dev/null
                                local res=$?
                                if [ $res -eq 0 ] #Command Success Test
                                then
					#if the command did not return error
                                        echo "acl user:$userGroup path:$path rights:$rights creat"
                                else
					#If cmmand return error
                                        echo "error acl not creat"
                                fi
                        fi

		fi

        done < $1


}

#dody of the program
function main()
{

existParam $@
creatAcl $@
}
main $@
