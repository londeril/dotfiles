# setting environment variables and stuff for GTK/QT Apps in non-gnome / non-kde sessions
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME GTK_THEME HYPRLAND_INSTANCE_SIGNATURE 
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORMTHEME GTK_THEME HYPRLAND_INSTANCE_SIGNATURE

