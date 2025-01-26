#!/bin/bash

while true; do
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  printf "%.2f\n" $CPU_USAGE
  sleep 0.5
done
