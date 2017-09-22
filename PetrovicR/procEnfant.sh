#!/bin/bash
function main ()
{
   procChildren $1
}

function procChildren()
{	
  children=$(grep "PPid:.*$1" /proc/[0-9]*/status | awk -F '/' '{print $3}')
  [[ -z $2 ]] && printf "%-20s %-20s %-20s\n" Noms Status Pid PPid
  awk '/^Name/ {printf "%-20s",$2} /^State/ {gsub("\(|\)","",$3); printf "%-20s",$3} /^Pid/ {printf "%-20d",$2} /^PPid/ {printf "%-20d\n",$2} ' /proc/$1/status 2> /dev/null
  for child in $children
  do
     procChildren $child 1
  done	
}

main $@	
