#! /bin/bash

function sys() 
{	
	echo "voici les disque:"
	ls /dev/sd*
	echo " "
	
	echo "le nombre de processus"
	ls /proc | grep -E ^[0-9] >>nbProces
	wc -w nbProces
	rm nbProces
	echo " "
	
	echo "voci l'uptme"
	uptime | awk -F'( |,|:)+' '{print $7" minutes",$8,"hours"}'

}

#dody of the program
function main()
{

	sys

}
main $@
