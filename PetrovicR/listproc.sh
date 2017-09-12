#!/bin/bash
function main()
{
}	
function affiche()
{
	lstpid=` ls /proc |grep -E ^[0-9]`
		for repetition in $lstpid
		do
			`egrep "Name|State|^[Pid]" /proc/$repetition/status`>>fic
			`awk -f " " fic`
		done
}
