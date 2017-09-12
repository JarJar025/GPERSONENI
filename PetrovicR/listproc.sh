#!/bin/bash
 function main()
	{ 
		affiche	
	}	
function affiche()
{
	lstpid=`ls /proc |grep -E ^[0-9]`
		for repetition in $lstpid
		do
			anwser=`awk '/^Name/ {printf "%s",$2} /^State/ {gsub("\(|\)"," ",$3); printf "%s",$3} /^Pid/{printf "%s\n",$2} ' /proc/$repetition/status`
	

		done
}
main $@
