#!/bin/bash

# times in seconds
SCREENSAVER=120
BATDIM=45
BATSCREEN=90
BATLOCK=120
BATSUSPEND=300
ACLOCK=305
OFFICESCREEN=300


swayidle -w \
                timeout $BATDIM '/home/daniel/.dotfiles/scripts/idle.sh BATDIM' resume '/home/daniel/.dotfiles/scripts/idle.sh BATUNDIM' \
                timeout $BATSCREEN '/home/daniel/.dotfiles/scripts/idle.sh BATSCREEN' \
                timeout $BATLOCK '/home/daniel/.dotfiles/scripts/idle.sh BATLOCK' \
                timeout $BATSUSPEND '/home/daniel/.dotfiles/scripts/idle.sh BATSUSPEND' \
                timeout $SCREENSAVER '/home/daniel/.dotfiles/scripts/idle.sh SCREENSAVER' resume '/home/daniel/.dotfiles/scripts/idle.sh KILLSAVER' \
                timeout $ACLOCK '/home/daniel/.dotfiles/scripts/idle.sh ACLOCK' \
                timeout $OFFICESCREEN '/home/daniel/.dotfiles/scripts/idle.sh OFFICESCREEN' 
