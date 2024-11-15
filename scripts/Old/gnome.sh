#!/bin/bash
echo "update font cache"
# update font cache
fc-cache -v

# set sane gnome defaults
echo "setting gnome defaults"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.mutter center-new-windows 'true'
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
gsettings set org.gnome.desktop.interface font-name 'Lato 10'
gsettings set org.gnome.desktop.interface document-font-name 'Lato 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace Regular 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Lato Bold 10'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'full'
gsettings set org.gnome.desktop.interface clock-show-weekday 'true'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:maximize,close'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Newaita-reborn-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'volantes_cursors'
gsettings set org.gtk.gtk4.settings.file-chooser sort-directories-first 'true'
gsettings set org.gnome.nautilus.list-view use-tree-view 'true'
gsettings set org.gnome.nautilus.icon-view captions "['size', 'type', 'none']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'
gsettings set org.gnome.desktop.wm.keybindings switch-applications '[]'
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward '[]'
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout '3600'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout '900'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'

#set keyboard shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'New Nautilus Window'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'<Super>e'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'nautilus -w'"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "'New Kitty Terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "'<Super>q'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "'kitty'"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "'1Password Quick Access'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "'<Shift><Control>space'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "'1password --quick-access'"

# update the keybinding list
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"


# set fav apps
echo "setting dock icons"
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'microsoft-edge.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Evolution.desktop', 'org.gnome.Geary.desktop', 'obsidian.desktop', '1password.desktop', 'org.remmina.Remmina.desktop', 'com.spotify.Client.desktop', 'kitty.desktop', 'anydesk.desktop']"

# change default shell to zsh this will ask for a password
#echo "change shell to zsh - this will prompt you for your password"
#chsh -s $(which zsh)