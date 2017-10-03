#!/bin/bash

# Main function
main () {
    # df -h gives mounted disks on the system
    echo "Mounted disks:" && df -h

    echo -e "\n"

    # Free gets free space on the system - h option gives human readable values
    echo "Displaying free space on system:" && free -h

    echo -e "\n"

    # Displaying current number of runing processes
    runningProc=$(ps aux | wc -l) && ((runningProc--)) && echo "Total number of running processes --> $runningProc"

    echo -e "\n"
    
    # Displaying the most expensive process for the system
    biggestProcess=$(ps aux | sort -nrk 3,3 | head -n 1) && echo "Biggest process running on the system --> $biggestProcess"
    
    echo -e "\n"

    # Displaying uptime of the system
    echo "Uptime:" && uptime | awk -F"," '{print $1,$2;}'

    echo -e "\n"

    # Displaying inodes free space
    echo "Free inodes:" && df -i

    echo -e "\n"

    # Displaying open ipcs on the system
    echo "Displaying all ipcs on the system " && ipcs -a
}

main $@
