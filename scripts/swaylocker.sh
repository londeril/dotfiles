#!/bin/sh
# swaylock-effects-git launcher
swaylock \
	--screenshots \
	--clock \
	--timestr %H:%M \
	--datestr "%d. %B %Y" \
	--indicator \
	--indicator-radius 100 \
	--indicator-thickness 7 \
	--effect-blur 7x5 \
	--effect-vignette 0.5:0.5 \
	--ring-color 0d73ccff \
	--key-hl-color 880033 \
	--line-color 00000000 \
	--inside-color 00000088 \
	--separator-color 00000000 \
	--grace 2 \
	--fade-in 0.2 \
	--font "Iosevka Nerd Font" \
	--font-size 36 \
	--text-color a0b3c5ff

