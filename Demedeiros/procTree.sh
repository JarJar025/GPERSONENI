#!/bin/bash
#This script get the list of child's pid




function getchildren()
{


    if [ -e /proc/$1/status ]
    then
         string_pid_ppid_status_name=$(awk '/^Pid/ {print $2 } /^PPid/ {print $2}/^Name/ {print $2} /^State/ {print toupper(substr($3,2,length($3)-2))}'  /proc/$1/status ) 
         format=$(echo $string_pid_ppid_status_name | awk '{printf "%-20d %-20d %-20s %-20s\n",$4,$3,$2,$1}') 
         convert=($format)
         ppid=$(echo ${convert[0]})
         pid=$(echo ${convert[1]})
         name=$(echo ${convert[3]})	
	 #get length of name and add +3
	 espace=$((${#name}+6))

         list_child=$(grep "PPid:.$1$" /proc/[0-9]*/status | awk -F '/' ' { print $3}')
         [ -z "$list_child" ]&& echo " $1 n'est pas un processus père"  
         array_list_child=($list_child)	
         array_list_child_sort=($(for i in ${array_list_child[@]};
          do
             echo $i;
          done | sort -n))
          printf "\n"

	  for i in ${!array_list_child_sort[@]}
	  do 
	    if [ $i -eq 0 ] 
	    then
		[ -e /proc/${array_list_child_sort[0]}/status ]&&child_name0=$(awk '/^Name/ {print $2}'  /proc/${array_list_child_sort[0]}/status ) || child_name0="unknown"
		echo " [$name]--- ${array_list_child_sort[0]}      $child_name0"
       	    else
		if [ -e /proc/${array_list_child_sort[$i]}/status ]
		then
	       	    child_name=$(awk '/^Name/ {print $2}'  /proc/${array_list_child_sort[$i]}/status )
		    printf "%"$espace"s %-8d %5s\n" "|__" "${array_list_child_sort[$i]}" "$child_name"		
		    children=$(grep "PPid:.${array_list_child_sort[$i]}$" /proc/[0-9]*/status | awk -F '/' ' { print $3}')
         	    if [ -n "$children" ] 
                    then
			#echo -e " \nles fils de ce processus ${array_list_child_sort[$i]}  sont  $children"
			convert3=($children)
			array_list_children_sort=($(for i in ${convert3[@]};
					           do
							echo $i  ;
						done | sort -n ))
			for j in ${!array_list_children_sort[@]}
			do
			  [ -e /proc/${array_list_child_sort[$j]}/status ]&&child_name2=$(awk '/^Name/ {print $2}'  /proc/${array_list_child_sort[$j]}/status ) || child_name2="unknown"
			  printf "%"$espace"s %-8d %5s\n" "             |___" "${array_list_children_sort[$j]}" "$child_name2"
			done
	            fi

		 else
		     child_name="unknown"
         	     printf "%"$espace"s %-8d %5s\n" "|__" "${array_list_child_sort[$i]}" "$child_name"		
        	 fi
	     fi
	 done
    fi
echo 
}


#This fonction show all children of each ppid process
function showchildren()
{

		#This variable contains  the list of all ppid process
		ppid_process=$(grep "PPid:.*" /proc/[0-9]*/status | awk  ' { print $2}' | sort -n | uniq)
		array_ppid_process=($ppid_process)

		#echo ${pid_dir[@]}
		for i in ${array_ppid_process[@]}
		do
		  getchildren "$i"
		done

}

function title()
{

     echo " ----------------------------------------------------------------------------"
     echo " |                                                                          |"
     echo " |  Ce script affiche la liste des processus parents ainsi que leur enfants |"
     echo " |                                                                          |"
     echo " ----------------------------------------------------------------------------"


}

function main()
{

title
echo " Pour afficher la liste de tous les processus pères et de leurs enfants : choisir 1"
echo " Pour afficher la liste de tous les enfants d'un processus père : choisir 2"
echo -e "\n Quel est votre choix  = \c ";read reponse

case $reponse in
 1)
	 
		showchildren
;;
2)



   z   printf "\n%s Quel est le pid du processus dont on veut les fils ?"
        echo -e "\n Saisir le PID du processus  = \c ";read pid_answer
		 #test if $pid_answer is empty
        [ -z $pid_answer ] && printf " Abandon du script, paramètre absent\n " && exit 1
        #test if $pid_answer is an integer
        if ((pid_answer)) 2> /dev/null
        then
                [ -e /proc/$pid_answer/status ]&& getchildren $pid_answer || echo -e"\n Le PID $pid_answer n'existe pas " && exit 2

        else
                printf " Saisir une valeur entière pour le PID "
                exit 1
        fi
;;
*)
		echo " Choix incorrect  "
		echo
		exit 2

;;
esac

}


main $@
exit 0












