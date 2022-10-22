#!/bin/bash

dates=$(date '+%d_%m_%y_%H:%M:%S')

mkdir "$HOME/test" 2>/dev/null &&
{
        echo "catalog test was created successfully" > "$HOME/report"
        touch "$HOME/test/$dates"
}
ping www.net_nikogo.ru 2>/dev/null || echo "${dates} ERROR" >> "$HOME/report"