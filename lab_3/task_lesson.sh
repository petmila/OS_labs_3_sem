#!/bin/bash

while true;
do
        pid=$(ps -eo pid,pcpu | awk '$2>=20.0{print$1}' | head -n 1)
        renice +10 -p $pid >/dev/null
done&