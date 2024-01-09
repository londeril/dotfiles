#!/bin/bash

# times in seconds
BATSCREEN=90
BATLOCK=120
BATSUSPEND=300
ACLOCK=305


swayidle -w \
                timeout $BATSCREEN '/home/daniel/.dotfiles/scripts/idle.sh BATSCREEN' \
                timeout $BATLOCK '/home/daniel/.dotfiles/scripts/idle.sh BATLOCK' \
                timeout $BATSUSPEND '/home/daniel/.dotfiles/scripts/idle.sh BATSUSPEND' \
                timeout $ACLOCK '/home/daniel/.dotfiles/scripts/idle.sh ACLOCK'
