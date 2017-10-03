#!/bin/bash

function  showMountDisk()
{
echo " Les disques montés"
disk=$(df | grep -e "^/dev" )
echo "$disk"
echo


}

function diskdispo(){

echo " Espace disque total disponible"
df -h /
echo
}

function up(){
 echo
 echo " Uptime du serveur "
 uptime

}
function nombreProc(){

echo " Nombre de processus en cours "
ps -aux | wc -l 
echo

}




function main(){

showMountDisk
diskdispo
nombreProc
up
}

main $@
exit 0
