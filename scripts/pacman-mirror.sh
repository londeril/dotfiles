#!/bin/bash

sudo reflector --verbose --protocol https --latest 5 --sort rate --country Switzerland --save /etc/pacman.d/mirrorlist
