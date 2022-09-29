#!/bin/bash

prc=$(ps -u user | tail -n +2 | awk '{print $1":"$4}')
cnt=$(echo "$prc" | wc -l)
echo "count = $cnt" > 1.out
echo "$prc" >> 1.out