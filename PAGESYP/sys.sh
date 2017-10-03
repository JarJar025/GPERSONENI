#!/bin/bash

echo -e " Les disques montés sont \n "
fdisk -l | grep /dev/sd
echo -e "\n"

echo -e "################################################################## \n"


echo -e " L'espace disque total restant est \n "
df -h | grep /dev/sd
echo -e "\n"


echo -e " Le nombre de processus en cours est de : "
ps aux | wc -l

echo -e " Le processus le plus goourmand en CPU est : "
#ps aux | awk -F " " '{print $3}'
