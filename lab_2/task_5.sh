#!/bin/bash

prev_ppid=0
sum=0
cnt=1

:> 5.out
echo -e "$(<4.out)\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" |

while read -r line
do
        pid=$(echo $line | awk '{print $1}')
        ppid=$(echo $line | awk '{print $2}')
        art=$(echo $line | awk '{print $3}')
        if [[ $ppid -eq $prev_ppid ]]
        then
                echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Running_Time="$art >> 5.out
                sum=$(echo "$sum + $art" | bc -l | awk '{printf "%.2f", $0}')
                cnt=$(( cnt+1 ))
        else
                avg=$(echo "$sum / $cnt" | bc -l | awk '{printf "%.2f", $0}')
                echo "Average_Children_Running_Time_of_ParentID="$prev_ppid" is "$avg >> 5.out
                echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_running_Time="$art >> 5.out
                sum=$art
                cnt=1
                prev_ppid=$ppid
        fi
done