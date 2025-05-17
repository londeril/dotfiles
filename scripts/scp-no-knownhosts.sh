#!/bin/bash
# this wrapper will call ssh the the $1 host without saving its hostkey in known_hosts
# use this to connect to one-off hosts

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $1 $2
