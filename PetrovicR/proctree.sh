#!/bin/bash

function procChildren()
{
#If user entry nothing

 if [ $# -eq 0 ]
  then
    echo "Please restart the script and  entry a parameter"
  else
#get the children of the process passed in parametre	

    children=$(grep "PPid:.*$1" /proc/[0-9]*/status | awk -F '/' '{print $3}')

#To display just 1 time the head table

    [[ -z $2 ]] && printf "%-20s %-20s %-20s %-20s\n" Noms Status Pid PPid

#awk to get information about the process and send error alert in the void
   
     awk '/^Name/ {printf "%-20s",$2} /^State/ {gsub("\(|\)","",$3); printf "%-20s",$3} /^Pid/ {printf "%-20d",$2} /^PPid/ {printf "%-20d\n",$2} ' /proc/$1/status 2> /dev/null

#Browse the childrens of a parents Process and to get informations about children  I call back my function
 
fi
 
for child in $children
 do
   procChildren $child 1
 done	
}

function main ()
{
  procChildren $1
}
#sort By PPID
main $@ | sort -k4n	
