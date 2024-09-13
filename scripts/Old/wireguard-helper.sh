#!/bin/sh
# this script will connect, disconnect or toggle wireguard interfaces - it's ment to be used with polybar - can be used interactively, too thought
# 
#
green=#55aa55

configs_path="/etc/wireguard"
connected_interface=$(nmcli | grep "wireguard" -B 1 | cut -d'"' -f2 -s)

connect() {
    selected_config=$(ls $configs_path/*.conf | xargs basename -a -s .conf | dmenu )
    [ $selected_config ] && pkexec wg-quick up "$configs_path"/"$selected_config".conf
}

disconnect() {
    # Normally we should have a single connected interface but technically
    # there's nothing stopping us from having multiple active intgerfaces so
    # let's do this in a loop:
    for connected_config in $(nmcli | grep "wireguard" -B 1 | cut -d'"' -f2 -s)
    do
        pkexec wg-quick down $configs_path/"$connected_config".conf
    done
}

toggle() {
    if [ $connected_interface ]
    then
        disconnect
    else
        connect
    fi
}

print() {
    if [ $connected_interface ]
    then
        echo %{u"$green"}%{+u}%{T4}%{F"$green"}%{T-}%{F-} "$connected_interface"
    else
        echo %{T4}%{T-}
    fi
}

case "$1" in
    --connect)
        connect
        ;;
    --disconnect)
        disconnect
        ;;
    --toggle)
        toggle
        ;;
    *)
        print
        ;;
esac