#!/bin/bash
#Creation : 26/09/2017

#This script allow you to create users from a .txt list and apply ACL to their personal repertory

#__________________________________________________________________________________________________

users_list=$1

function users_creation()
{
        echo "This script allows you to create users and apply generic rights to them, using a text file defined as a parameter, for exemple << user_rights.sh file.txt >>
This file must be structured by line as follows : << username:group:password >>
Is it ok for you ? (Y/N)"
        read answer
        if [ $answer = "N" ]#Check if we stop or not
                then
                        echo "Exit."
                        exit
        elif [ -e $users_list ]#If the list exist
                then
                        while IFS=: read user group password rights #Users/Directory creation and ACL configuration
                        do
                                useradd -g $group -p $password -m -d "/home/$user" $user -s /bin/bash #Complete creation of the user and his personal directory
                                if [ -e "/home/$user" ]
                                        then
                                                setfacl -R -m "u:$user:$rights" "/home/$user" #ACL Creation on the user's directory
						printf "\nUser created.\n"
                                fi
                        done < $users_list
                else
                        echo "ERREUR : $users_list No such file or directory."
        fi
}

function main()
{
        users_creation
#       access_lists
}

main
