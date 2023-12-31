#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/polybar/shapes/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
shutdown="	Shutdown"
reboot="	Restart"
dock="󱂬	Dock"
undock="	Undock"
lock="	Lock"
suspend="	Sleep"
logout="	Logout"

# Confirmation
confirm_exit() {
	rofi -dmenu\
        -no-config\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -no-config -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$suspend\n$dock\n$undock\n$lock\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		systemctl poweroff
	    ;;
    $reboot)
		systemctl reboot
		;;
    $lock)
		xscreensaver-command --lock
		;;
    $suspend)
		#ans=$(confirm_exit &)
		#if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		#	mpc -q pause
		#	amixer set Master mute
		#	xscreensaver-command --lock
		#	systemctl suspend
		#elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
		#	exit 0
        #else
		#	msg
        #fi
        #;;
        mpc -q pause
		amixer set Master mute
		xscreensaver-command --lock
		systemctl suspend
        ;;
    $logout)
		bspc quit
	    ;;
	$dock)
		~/.dotfiles/scripts/docker-helper.sh --dock
		;;
	$undock)
		~/.dotfiles/scripts/docker-helper.sh --undock
		;;
esac
