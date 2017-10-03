#!/bin/bash
#This script set acl by reading a formatting text on file


#This function set a acl
#It takes 3 params :
#$1 : directory , $2 : target , $3 : rights
function setAcl()
{
local user="/etc/passwd"
local group="/etc/group"


    if [ -z "$1" -a -z "$2" -a -z "$3" ]
    then
        echo " Absence de paramètres "
        exit 2
    fi
    echo
    echo " Recherche de l'utilisateur $2 ..."
    if grep -q "$2" $user
    then
         echo "  > Utilisateur $2 trouvé dans $user "
         echo "  > Mise à jour des acls sur $1 "
         [ ${#3} -gt 3 ] && echo " Longueur du champ droit incorrect " && exit 1
         [ "$3" != "r--" -a "$3" != "rw-" -a "$3" != "rwx" -a "$3" != "r-x" -a "$3" != "-w-" -a "$3" != "-wx" -a "$3" != "--x" ] && echo " Format inconnu du champ droits " && exit 1 
     
        if [ -d $1 ]
        then
            setfacl -Rm u:"$2":"$3" "$1" 
            return_code1=$?
            [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie " 
        else
            mkdir -p $1
            setfacl -Rm u:"$2":"$3" "$1"
            return_code1=$?
            [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie "
        fi
    else
        echo "  > Utilisateur $2 inexistant dans $user"	
        echo " 	> Creation de l'utilisateur $2 "
        useradd -U $2
        [ ${#3} -gt 3 ] && echo " Longueur du champ droit incorrect " && exit 1
        [ "$3" != "r--" -a "$3" != "rw-" -a "$3" != "rwx" -a "$3" != "r-x" -a "$3" != "-w-" -a "$3" != "-wx" -a "$3" != "--x" ] && echo " Format inconnu du champ droits " && exit 1
        if [ -d $1 ]
        then
            setfacl -Rm u:"$2":"$3" "$1"
            return_code1=$?
            [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie " 
        else
            mkdir -p $1
            setfacl -Rm u:"$2":"$3" "$1"
            return_code1=$?
            [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie "
       fi                
   fi

   echo
   echo " Recherche du groupe $2 ..."
       if grep -q "$2" $group
        then
             echo "  > Groupe $2 trouvé dans $group "
             echo "  > Mise à jour des acl sur $1 "
             [ ${#3} -gt 3 ] && echo " Longueur du champ droit incorrect " && exit 1
             [ "$3" != "r--" -a "$3" != "rw-" -a "$3" != "rwx" -a "$3" != "r-x" -a "$3" != "-w-" -a "$3" != "-wx" -a "$3" != "--x" ] && echo " Format inconnu du champ droits " && exit 1

             if [ -d $1 ]
             then
                 setfacl -Rm g:"$2":"$3" "$1"
                 return_code1=$?
                 [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie " 
             else
                 mkdir -p $1
                 setfacl -Rm g:"$2":"$3" "$1"
                 return_code1=$?
                 [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie "
             fi
        else
            echo "  > Groupe $2 inexistant dans $group" 
            echo "  > Creation du groupe $2 "
             groupadd $2
             [ "$3" != "r--" -a "$3" != "rw-" -a "$3" != "rwx" -a "$3" != "r-x" -a "$3" != "-w-" -a "$3" != "-wx" -a "$3" != "--x" ] && echo " Format inconnu du champ droits " && exit 1
             if [ -d $1 ]
             then
                 setfacl -Rm g:"$2":"$3" "$1"
                 return_code1=$?
                 [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie " 
             else
                 mkdir -p $1
                 setfacl -Rm g:"$2":"$3" "$1"
                 return_code1=$?
                 [ $return_code1 -eq 0  ] && echo "  > Commande setfacl réussie "
             fi
        fi

}


function read_file()
{
    for i in ${array_myfile[@]}
    do
      directory=$(echo $i | cut -d : -f1) 
      target=$(echo $i | cut -d : -f2)
      rights=$(echo $i | cut -d : -f3)
      setAcl "$directory" "$target" "$rights" 
    done


    echo
}

function title()
{

     echo " ----------------------------------------------------------------------------"
     echo " |                                                                          |"
     echo " |          Ce script définit des acls sur des répertoires                  |"
     echo " |                                                                          |"
     echo " ----------------------------------------------------------------------------"


}

function main()
{

    if [ -n "$1" ]
    then
        title
        myfile=$( < $1)
        array_myfile=($myfile)
        read_file
    else
        title
        echo 
        echo " Le fichier d'analyse en  paramètre absent : abandon de importAcl.sh "
        echo
        exit 2
    fi

}



main $@
exit 0





