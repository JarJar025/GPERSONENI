#!/bin/bash
 function main()
	{ 
		affiche	
	}	
function affiche()
{	
	printf "%s"
	lstpid=`ls /proc |grep -E ^[0-9]`
		for repetition in $lstpid
		do
			awk '/^Name/ {printf "%s",$2} /^State/ {gsub("\(|\)"," ",$3); printf "%s",$3} /^Pid/ {printf "%s\n",$2} ' /proc/$repetition/status 2> /dev/null
		
		done
}
main $@
