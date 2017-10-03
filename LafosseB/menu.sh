#!/bin/bash

# Checking if our user exists
checkUser () {
    echo "Please provide a username to check..."
    read username

    if id "$username" >/dev/null 2>&1
    then
        echo "User $username exists."
    else
        echo "User $username does not exist."
    fi
    sleep 2 && clear
}

# Function fetchning the UID of a given username
checkUID () {
    echo "Please provide a username to fetch its UID..."
    read username
    # Checking if user exists
    if id "$username" >/dev/null 2>&1
    then
        # Fetching UID
        uuidUser=$(awk -F":" '/^'$username'/ {print $3};' /etc/passwd)
        echo "UID of user $username is --> $uuidUser"
    else
        echo "User $username is an invalid username."
    fi
    sleep 3 && clear
}

# Main function
main () {
# Cleaning screen at the begining of the script
clear
# Configuring our menu
    PS3='Select '
    while :
    do
        options=("CheckUser ${opts[1]}" "UIDChecker ${opts[2]}" "Quit")
        select opt in "${options[@]}"
        do
            case $opt in
                "CheckUser ${opts[1]}")
                    checkUser
                    break
                    ;;
                "UIDChecker ${opts[2]}")
                    checkUID
                    break
                    ;;
                "Quit")
                    exit
                    ;;
                *) printf '%s\n' 'Bad option...';;
            esac
        done
    done
}

main $@
