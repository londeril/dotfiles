#!/bin/bash
# display a live graph for cpu frequencies
watch -n0.1 "grep '^[c]pu MHz' /proc/cpuinfo | column"
