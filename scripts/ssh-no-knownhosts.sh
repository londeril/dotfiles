#!/bin/bash
# this wrapper will call ssh the the $1 host without saving its hostkey in known_hosts
# use this to connect to one-off hosts

ssh $1 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no