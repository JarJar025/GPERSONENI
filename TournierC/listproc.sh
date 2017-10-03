#!/bin/bash

#This script allow you to list every enabled process
#listed by Pid, Name, and State

#ALPHA VERSION

<<<<<<< HEAD
printf "\n%-20s %-20s %-20s %-20s %-20s\n" **PID** **PPid** **NAME** **STATE**
=======
printf "\n%-20s %-20s %-20s %-20s\n" **PID** **NAME** **STATE** **KB_MEM**
>>>>>>> 8a58c2c2044aa631c4d4069b3df2a485a9059ded

function new_ps()
{
	local processus_rep=`ls /proc | grep -E ^[0-9]`
	
	for rep in $processus_rep
	do
		if [ -e /proc/$rep/status ] 
		then
<<<<<<< HEAD
			local process=$(mawk '/^Pid|^Name|^PPid/ {printf "%s ",$2} /^State/ {gsub("\(sleeping\)","SLEEPING", $3); printf "%s ",$3}' /proc/$rep/status)
			echo $process | awk '{printf "%-20d %-20d %-20s %-20s\n",$3,$4,$1,$2}' >> /tmp/test_listproc.txt 	
		fi
	done 

=======
			local process=$(awk '/^Pid|^Name|^VmRSS/ {printf "%s ",$2} /^State/ {gsub("\(sleeping\)","SLEEPING", $3); printf "%s ",$3}' /proc/$rep/status)
			echo $process | awk '{printf "%-20d %-20s %-20s %-20d\n",$3,$1,$2,$4}' >> /tmp/test_listproc.txt 	

#			name=`grep -s "Name" /proc/$rep/status | awk '{print $NF}'`
#			pid=`grep -s "^Pid" /proc/$rep/status | awk '{print NF}'`
#			state=`grep -s "State" /proc/$rep/status | awk '{print $2 $3}'`
#			printf "%-25s%25s%25s\n "$name "$pid "$state
		fi
	done
>>>>>>> 8a58c2c2044aa631c4d4069b3df2a485a9059ded
	cat /tmp/test_listproc.txt | sort -nk 1
	rm /tmp/test_listproc.txt
}

<<<<<<< HEAD
#	for childs in /proc/*/status
=======
#function kill_ps()
#{
	
#}
>>>>>>> 8a58c2c2044aa631c4d4069b3df2a485a9059ded

function main()
{
	new_ps
}

main
