#!/bin/bash
./mem.sh&pid0=$!
./mem2.sh&pid1=$!
rm data1
rm data2
title="MiB_Mem_free MiB_Mem_used MiB_Mem_cache MiB_Swap_free MiB_Swap_used MiB_Swap_avail "
title+="TIME MEM VIRT RES SHR CPU FREE SWAP COMMAND "
echo -e $title > data1
echo -e $title > data2
echo "1COMMAND 2COMMAND 3COMMAND 4COMMAND 5COMMAND" > data_process
while [ true ]
do
    top -bn1 | head -n 4 | tail -n 1 | awk {'printf("%s %s %s ", $6, $8, $10)'} >> data1
    top -bn1 | head -n 5 | tail -n 1 | awk {'printf("%s %s %s ", $5, $7, $9)'} >> data1

    line=$(top -p $pid0 -b -n 1 | head -8 | tail -n +8 )
    line=$(echo -e $line | awk '{print ""$11" "$10" "$5" "$6" "$7" "$9" "$12""}')
    line=$(echo -e "$line\n")
    echo $line >> data1

    line=$(top -p $pid1 -b -n 1 | head -8 | tail -n +8 )
    line=$(echo -e $line | awk '{print ""$11" "$10" "$5" "$6" "$7" "$9" "$12""}')
    line=$(echo -e "$line\n")
    echo $line >> data2
    top -bn1 | head -n 8 | tail -n 1 | awk {'printf("%s ", $12)'} >> data_process
    top -bn1 | head -n 9 | tail -n 1 | awk {'printf("%s ", $12)'} >> data_process
    top -bn1 | head -n 10 | tail -n 1 | awk {'printf("%s ", $12)'} >> data_process
    top -bn1 | head -n 11 | tail -n 1 | awk {'printf("%s ", $12)'} >> data_process
    top -bn1 | head -n 12 | tail -n 1 | awk {'printf("%s ", $12)'} >> data_process
    echo "" >> data_process
done