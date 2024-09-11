#!/bin/bash
# updatemirrors.sh  - update your mirrors

reflector --country Switzerland,Germany --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist --verbose

