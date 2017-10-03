#!/bin/bash

function sysView(){

	mountDrive=$(find /dev -iname "sd*") 
	echo "les disques montés sur le système sont $mountDrive"

}

function main(){

	sysView
}

main $@
