#!/bin/bash

for pid in $(ps -axo pid | tail -n +2)
do
        if [[ -r /proc/$pid/status ]]
        then
                lib=$(grep -s "VmLib" /proc/$pid/status | awk '{print $2}')
                if [[ "$lib" -eq "" ]]
                then
                        echo $pid
                fi
        fi
done