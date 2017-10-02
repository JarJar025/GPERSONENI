#!/bin/bash
function main ()
	{
		procChildren |sort -k3n
	}
function procChildren()
{	
	print "%s"
	printf "%-20s" Noms  Status Pid 
	printf "\n"
	lstpid=`ls /proc |grep -E ^[0-9]`
		for repetition in $lstpid
		do
			awk '/^Name/ {printf "%-20s",$2} /^State/ {gsub("\(|\)"," ",$3); printf "%-20s",$3} /^Pid/ {printf "%-20d\n",$2} ' /proc/$repetition/status 2> /dev/null
		
		done
}
main $@	
