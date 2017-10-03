#!/bin/bash
#This script shows system information
function systeminfo()
{
	mountdisk=$(fdisk -l)
	printf "$mountdisk \n"
	nbproc=$(ps -aef | awk '{ print $3 }' | wc -l)
	printf "There are $nbproc ongoing process \n"
}
function main()
{
	systeminfo
}
main $@

