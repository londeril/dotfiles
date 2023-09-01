#!/bin/sh
# prepare system to run the arch install sctipts
for script in `find ./* -name "*.sh"`; do chmod +x $script; done