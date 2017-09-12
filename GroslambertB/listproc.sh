#! /bin/bash

#dody of the program
function getProccess()
{
	# get PID number in var lesPid
	lesPid=$(ls /proc | grep -E ^[0-9])
	printf "%-20s" Name Statu PID
	printf "\n\r"

	#loop "for": displays on the standard input the name of the processes in operation, the PID and the statuses. Redirects errors to black hole
	for lePid in $lesPid; do
		awk '/^Pid/{printf "%-20d\n", $2 } /^State/{gsub("\(|\)","",$3); printf "%-20s", $3} /^Name/{printf "%-20s",$2}' /proc/$lePid/status 2> /dev/null
	done	
}

function killStopProccess()
{	
	#kill proccess
	printf "Do you want kill/stop a process?  y/n \n"
	read doYouWantKill
	if [ $doYouWantKill = "y" ]
	then
		#choose process end mode
		printf "kill or stop k/s \n"
		read killStop
		if [ $killStop = "s" ] #if user choose this option, proccess will be arrested (properly)
		then
			printf "give the PID of the killing proccess \n"
			read proccessKill
			#verification of the numerer type of the response
			if let $proccessKill 2>/dev/nul 
			then
		
				nameProccessKill=$(awk '/^Name/{printf $2}' /proc/$proccessKill/status 2> /dev/nul)
				kill $proccessKill 2> /dev/null
				res=$?
				if [ $res -eq 0 ] #Command Success Test
				then
					printf "Process $proccessKill $nameProccessKill was stoped \n"
				else
					printf "stopping the process in failure \n"
				fi
			else 
				printf "the entered value is not an integer \n"
			fi
		elif [ $killStop = "k" ]  #if user choose this option, proccess will be roughly
		then
			printf "give the PID of the killing proccess \n"
                        read proccessKill
			#verification of the numerer type of the response
                        if let $proccessKill 2>/dev/nul
                        then

                                nameProccessKill=$(awk '/^Name/{printf $2}' /proc/$proccessKill/status 2> /dev/nul)
                                kill -9 $proccessKill 2> /dev/null
				res=$?
                                if [ $res -eq 0 ] #Command Success Test
                                then
                                        printf "Process $proccessKill $nameProccessKill was killing \n"
                                else
                                        printf "stopping the process in failure \n"
                                fi

                        else
                                printf "the entered value is not an integer \n"
                        fi
			

		fi
	fi
}

function main()
{
getProccess
killStopProccess
}
main $@
