#!/bin/bash

function vulgarisationStatus ()
{
    if [ $1 == "S" ]
    then
        statusProcV="WAITING"
    else
        statusProcV="AUTRE"    
    fi
}

listeProc=$(ls /proc | grep -e ^[0-9])

echo -n "Liste des processus (PID): "
echo $listeProc

for unProc in $listeProc
{
    if [ -e /proc/$unProc/status ] 
    then
        nomProc=$(grep Name /proc/$unProc/status | awk '{ print $2 }')
        statusProc=$(grep State /proc/$unProc/status | awk '{ print $2 }')

        #statusProcV=""
        vulgarisationStatus $statusProc

        chaine="Status du processus $nomProc --> $statusProcV"
        echo $chaine
    fi 
}
