#!/bin/bash
# start kdewalet - but check if it's running first... running multiple ssh-agents will cause all sorts of headaches
if ! pgrep -x "ssh-agent" &>/dev/null; then
        eval "$(ssh-agent)"
fi