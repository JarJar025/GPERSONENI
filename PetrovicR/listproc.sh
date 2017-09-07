#!/bin/sh

lstpid=` ls /proc |grep -E ^[0-9]`

for repetition in $lstpid
do
	`egrep "Name|State|^[Pid]" /proc/$repetition/status`>>fic
	`awk -f " " fic` 
	#mesNoms=`egrep "Name" /proc/$repetition/status`>>Noms
	#mesStates=`egrep "State" /proc/$repetition/status`>>States
	#mesPids=`egrep "^[Pid]" /proc/$repetition/status` >>Pids
	echo "$var2"
done
