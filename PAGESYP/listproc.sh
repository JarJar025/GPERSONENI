#!/bin/bash

#Ce script a pour but de récupérer le nom et le status des processus

repBoucle=`ls /proc | grep -E ^[0-9]`

function folderBoucle (){
for fold in $repBoucle
do
	awk '/^Name/{printf "\n%-20s",$2}/^State/{gsub("\(|\)"," ",$3);printf "%20s",$3}/^Pid/{printf "%20s\n",$2}' /proc/$fold/status
#	printf " `grep Name /proc/$fold/status`\n" 
#	printf " `grep ^Pid /proc/$fold/status` \n" 
#	printf " `grep State /proc/$fold/status` \n"

done
}

#Appel de la fonction FolderBoucle
folderBoucle

