#!/bin/bash
# lock machine wait 3 seconds and suspend machine - this will help the machine to resume with a locked session

loginctl lock-session
sleep 3
systemctl suspend