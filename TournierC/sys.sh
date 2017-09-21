#!/bin/bash

#____________________________________________________________

function mounted()
{
	printf "\n_______________________________________________\n"
	printf "Here is the current disks on your system\n"
	printf "_______________________________________________\n"
	fdisk -l
}

function space_available()
{
	printf "\n_______________________________________________\n"
	printf "Here is the total available disk space on your system\n"
	printf "_______________________________________________\n"
	df -k -h
}

function total_proc()
{
	printf "\n_______________________________________________\n"
	printf "Here is the total number of the current process\n"
	printf "_______________________________________________\n"
	local total=`ls -d /proc/[0-9]* | wc -w`
	echo "Your system count $total process."
}

function biggest_proccpu()
{
	printf "\n_______________________________________________\n"
	printf "Here is the most CPU-intensive process\n"
	printf "_______________________________________________\n"
	ps -eo pmem,pcpu,pid,args | tail -n +2 | sort -rnk 2 | head | sed -n 1p
}

function main()
{
	mounted
	space_available
	total_proc
	biggest_proccpu
}

main
