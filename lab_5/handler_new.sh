#!/bin/bash

for i in $(seq 1 $1);do
        ./newmem.sh $2 &
done