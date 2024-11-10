#!/bin/bash
# display a live graph for cpu frequencies
#watch -n0.1 "grep '^[c]pu MHz' /proc/cpuinfo | column"
watch -n0.5 "grep '^[c]pu MHz' /proc/cpuinfo | awk '{if (\$4 >= 4000) printf \"\033[32m%s\033[0m\n\", \$0; else print \$0}' | column -t"
