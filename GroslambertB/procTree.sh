#! /bin/bash

#hello function that returns a message on the standard output
function getPid() 
{
	#this function allows to list the child processes of the process pere to pass in parameter of the script
	process=$(awk '/^Pid/{printf "%-20d\n", $2 } /^PPid/{printf "%-20d\n",$2} /^State/{gsub("\(|\)","",$3); printf "%-20s", $3} /^Name/{printf "%-20s",$2}' /proc/$1/status 2> /dev/null)
	echo $process	
#	printf "$1 $2\n"$process
	pid=$(awk '/^Pid/{printf $2}' /proc/$1/status 2> /dev/null)

	pidsProces=$(ls /proc | grep -E ^[0-9])
	
	for pidProcess in $pidsProces; do

		ppid=$(awk '/^PPid/{printf $2}' /proc/$pidProcess/status 2> /dev/null)
		if [[ $ppid -eq $pid ]]
		then
			#childrenProc=$(awk '/^Pid/{printf "%-20d", $2 } /^PPid/{printf "%-20d\n",$2} /^State/{gsub("\(|\)","",$3); printf "%-20s", $3} /^Name/{printf "%-20s",$2}' /proc/$pidProcess/status 2> /dev/null)
			childProc=$(awk '/^Pid/{printf $2}' /proc/$pidProcess/status 2> /dev/null)
#			echo "+---$childProc"
			listChildProc=$childProc,$listChildProc
		fi
	done
	echo $listChildProc

}

function getPid2()
{
	#this function allows to list the child processes of the process pere to pass in parameter of the script
	process=$(awk '/^Pid/{printf "%-20d\n", $2 } /^PPid/{printf "%-20d\n",$2} /^State/{gsub("\(|\)","",$3); printf "%-20s", $3} /^Name/{printf "%-20s",$2}' /proc/$1/status 2> /dev/null)
        echo $process
        pid=$(awk '/^Pid/{printf $2}' /proc/$1/status 2> /dev/null)
	child=$(grep "PPid:.*$pid" /proc/[0-9]*/status | awk -F '/' '{printf $3}')
	echo $child
}

#dody of the program
function main()
{

#	getPid $@
	getPid2 $@

}
main $@
