#!/bin/bash

at now + 2 minutes -f ./1.sh
tail -f -n 0 "$HOME/report"