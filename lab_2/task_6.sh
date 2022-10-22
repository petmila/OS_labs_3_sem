#!/bin/bash

declare -i max
declare -i ans

for pid in $(ps -axo pid | tail -n +2)
do
        # проверка на то, что в папке status что-то лежит под этим pid
        if [[ -r /proc/$pid/status ]]
        then
                # записываем в переменую кол-во затраченной памяти на проект
                memory=$(grep -s "VmHWM" /proc/$pid/status | awk '{print $2}')
                if [[ $memory != "" ]]
                then
                        # если память больше максимального
                        if [[ $memory -gt $max ]]
                        then
                                ans=$pid
                                max=$memory
                        fi
                fi
        fi
done

echo "PID:" $ans "Memory:" $max
echo "top max pid $(top -b -n 1 | tail -n +8 | sort -n -r -k 10 | head -1 | awk '{print $1}')"