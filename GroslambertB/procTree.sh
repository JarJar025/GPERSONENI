#! /bin/bash

#dody of the  program listpproc

function getProccess()
{
	rm tempo 2> /dev/null
	rm fileSortProc 2> /dev/null
	
	# get PID number in var lesPid
	lesPid=$(ls /proc | grep -E ^[0-9])
	#printf "%-20s" PID PPID Name Statu >>tempo
	#printf "\n\r">>tempo

	#loop "for": displays on the standard input the name of the processes in operation, the PID and the statuses. Redirects errors to black hole
	for lePid in $lesPid; do
		ligneProc=$(awk '/^Pid/{printf "%-20d",$2 } /^PPid/{printf "%-20d\n",$2} /^State/{gsub("\(|\)","",$3); printf "%-20s",$3} /^Name/{printf "%-20s",$2}' /proc/$lePid/status 2> /dev/null)
		echo $ligneProc | awk '{printf "%-20d %-20d %-20s %-20s\n", $3,$4,$1,$2}' >>tempo
	done
	tmp=tempo
	sort -n -k 1 $tmp >>fileSortProc
#nous avons réfléchi en classe entière pour trouver une solution pour la trie par PID et avec le processus père Il nous a fallu beaucoup de temps pour trouver une piste solide. nous continuerons le reste du script lors du TP de mercredi
# voici notre réffexion 

#Sort the PID by PPID like a tree, with the whole class we think about do that

#For each PID
	#Get PPID and PID
		#If PPID exists in tab[]
			#Create tab[PPID]
		#Else
			#Add PID in tab[PPID]
		#Fi
#done

#And we loop on the table tab[] to print the results

		
}


# Fetch all children of a given Parent
function getChildPID() {
cpids=`pgrep -P $1|xargs`
# Displaying PIDs
    for cpid in $cpids;
    do
        echo "    $cpid"
        #getChildPID $cpid
    done
}

function main()
{
function array_key_exists() {
    local _array_name="$1"
    local _key="$2"
    local _cmd='echo ${!'$_array_name'[@]}'
    local _array_keys=($(eval $_cmd))
    local _key_exists=$(echo " ${_array_keys[@]} " | grep " $_key " &>/dev/null; echo $?)
    [[ "$_key_exists" = "0" ]] && return 0 || return 1
}

processList=$(ls /proc | grep -e ^[0-9] | sort -n)
for process in $processList;
do
	# Fetching the required elements
	pidProc=$(awk '/^Pid/ {print $2;}' /proc/$process/status 2> /dev/null)
	ppidProc=$(awk '/^PPid/ {print $2;}' /proc/$process/status 2> /dev/null)

	# Creating new hash table
	declare -A processArray
	if [[ "$(array_key_exists 'processArray' $ppidProc; echo $?)" = "0" ]]; then
		processArray[$ppidProc]+=",$pidProc" 
	else
		if [ ! -z "$ppidProc" ] 
        	then
			processArray[$ppidProc]="$pidProc"
		fi
	fi
done


# Formatting the display of our result
for i in "${!processArray[@]}"
do
	echo "$i"
	echo "    :${processArray[$i]}"
done

}
main $@
