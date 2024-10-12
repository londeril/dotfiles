# setting environment variables and stuff for GTK/QT Apps in non-gnome / non-kde sessions
systemctl --user import-environment WAYLAND_DISPLAY QT_QPA_PLATFORMTHEME GTK_THEME XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY QT_QPA_PLATFORMTHEME GTK_THEME XDG_CURRENT_DESKTOP=Hyprland
