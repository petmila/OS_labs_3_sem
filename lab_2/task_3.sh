#!/bin/bash

ps -o pid,start_time --sort=start_time | head -2 | tail -1 | awk '{print($1)}'