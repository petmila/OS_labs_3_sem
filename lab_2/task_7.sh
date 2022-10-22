#!/bin/bash


declare -a start_data
declare -a end_data
declare -a pids
declare -a cmdline

:>7.out

for pid in $(ps -axo pid | tail -n +2)
do
        if [[ -r /proc/$pid/io ]]
        then
                start_data[$pid]=`(grep -s "rchar:" /proc/$pid/io | awk '{print $2}')`
                pids[$pid]="$pid"
                cmdline[$pid]=`(cat /proc/$pid/cmdline | tr -d '\0')`
        fi
done

sleep 1m

for pid in ${pids[*]}
do
        end_data[$pid]=`(grep -s "rchar:" /proc/$pid/io | awk '{print $2}')`
done

for pid in ${pids[*]}
do
        let diff=${end_data[$pid]}-${start_data[$pid]}
        echo "$pid $diff ${cmdline[$pid]}" >> 7.out
done

sort -nrk2 7.out | head -3 | awk '{print $1":"$2":"$3}'