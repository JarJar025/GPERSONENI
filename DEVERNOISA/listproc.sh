#!/bin/bash

function liste()
{
liste=$( ls /proc/ | grep -E ^[0-9] )
}
liste

for valeur in $liste 
do
	echo "`egrep "Name|State|^Pid" /proc/$valeur/status`" 
done
