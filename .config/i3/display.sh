#!/bin/bash

xStatus=`xrandr`
connectedOutputs=$(echo "$xStatus" | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
activeOutput=$(echo "$xStatus" | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/") 
connected=$(echo $connectedOutputs | wc -w)

execute="xrandr "
i=1

for display in $connectedOutputs
do
    if [ $connected -eq 1 ]
    then
        execute=$execute"--output $display --auto --primary "
        break
    else
        if [ $i -eq 1 ]
        then
            execute=$execute"--output $display --off --primary "
            i=$(( $i + 1 ))
        else
            execute=$execute"--output $display --pos 0x0 --mode 1920x1080"
        fi
    fi
done

echo "Command: $execute"
`$execute`
