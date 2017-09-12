#! /bin/bash


#dody of the program
function main()
{
	# get PID number in var lesPid
	lesPid=$(ls /proc | grep [0-65535])

	
	for lePid in $lesPid; do
		nameProc=$(grep -E  "Name" /proc/$lePid/status | awk -F":" '{print $2}' )
		statusProc=$(grep -E  "State" /proc/$lePid/status | awk -F":" '{print $2}')  
		
		printf $lePid /r 
		echo $nameProc
		echo $statusProc		

	done	


}
main $@
