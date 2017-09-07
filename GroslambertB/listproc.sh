#! /bin/bash


#dody of the program
function main()
{
	# get PID number in var lesPid
	lesPid=$(ls /proc | grep [0-65535])

	
	for lePid in $lesPid; do
		/proc/lePid	
	done	


}
main $@
