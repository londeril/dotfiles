#!/bin/sh
# run this on the freshly installed system
echo "creating user dirs"
mkdir ~/Downloads
mkdir ~/Documents
mkdir ~/Pictures
mkdir ~/Pictures/Screenshots
mkdir ~/Pictures/Wallpapers
mkdir ~/Pictures/ScreensaverPics
mkdir ~/Data
#mkdir ~/.dotfiles
#mkdir ~/.config

echo "copy configs in place and symlinking them"
#ln -s ~/.dotfiles/hypr ~/.config/
ln -s ~/.dotfiles/zsh ~/.config/
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
#ln -s ~/.dotfiles/kitty ~/.config/
#ln -s ~/.dotfiles/waybar ~/.config/
#ln -s ~/.dotfiles/fuzzel ~/.config/
ln -s ~/.dotfiles/icons ~/.icons
ln -s ~/.dotfiles/themes ~/.themes
ln -s ~/.dotfiles/gtk-3.0 ~/.config/
ln -s ~/.dotfiles/gtk-3.0 ~/.config/gtk-4.0
ln -s ~/.dotfiles/btop ~/.config/
ln -s ~/.dotfiles/neofetch ~/.config/
ln -s ~/.dotfiles/ranger ~/.config/
#ln -s ~/.dotfiles/dunst ~/.config/

#echo "copy Gradience themes"
#cp ~/.dotfiles/Gradience/blueish.json ~/.var/app/com.github.GradienceTeam.Gradience/config/presets/user/

#sudo ln -s ~/.dotfiles/hypr/hyprlaunch.sh /usr/bin/hyprlaunch

echo "enabling mdns"
cp ~/.dotfiles/archinstall/nsswitch.conf /etc/

#echo "copy fonts"
# cp fonts
#fc-cache -fv

echo "setting global git username"
git config --global user.email "daniel@dashwood.ch"
git config --global user.name "Daniel"

echo "installing yay"
cd ~/Downloads
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si

echo "adding 1password keys"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

echo "adding sublime-text"
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu sublime-text

#echo "installing VMware Remote Console - fist yay run will fail... this's expected"
#yay -S vmware-vmrc
#cp ~/archinstall/vmrc/* ~/.cache/yay/vmware-vmrc/
#yay -S vmware-vmrc

echo "getting needed packages from the AUR"
#yay -S sublime-text-4 1password anydesk-bin pcloud insync typora input-remapper-git nccm-git swaylock-effects-git 
yay -S 1password insync input-remapper-git nccm-git

echo "deploying nccm wrapper"
sudo mv /usr/bin/nccm /usr/bin/nccm-bin
sudo ln -s ~/.dotfiles/scripts/nccmwrapper.sh /usr/bin/nccm

echo "installing flatpaks"
flatpak install \
com.github.tchx84.Flatseal \
com.microsoft.Edge \
com.parsecgaming.parsec \
com.rtosta.zapzap \
com.spotify.Client \
com.todoist.Todoist \
com.valvesoftware.Steam \
org.onlyoffice.desktopeditors \
com.discordapp.Discord \
io.github.flattool.Warehouse \
com.anydesk.Anydesk \
-y

#echo "setting default browser to firefox"
#xdg-settings set default-web-browser firefox.desktop

# set sane gnome defaults
#echo "setting gnome defaults"
#gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
#gsettings set org.gnome.mutter center-new-windows 'true'
#gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
#gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'
#gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'
#gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace Regular 10'
#gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 10'
#gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
#gsettings set org.gnome.desktop.interface font-hinting 'full'
#gsettings set org.gnome.desktop.interface clock-show-weekday 'true'
#gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:maximize,close'
#gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
#gsettings set org.gnome.desktop.interface icon-theme 'Newaita-reborn-dark'
#gsettings set org.gnome.desktop.interface cursor-theme 'volantes_cursors'
#gsettings set org.gtk.gtk4.settings.file-chooser sort-directories-first 'true'
#gsettings set org.gnome.nautilus.list-view use-tree-view 'true'
#gsettings set org.gnome.nautilus.icon-view captions "['size', 'type', 'none']"
#gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"
#gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'
#gsettings set org.gnome.desktop.wm.keybindings switch-applications '[]'
#gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward '[]'
#gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
#gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
#gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout '3600'
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout '900'
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'

#set keyboard shortcuts
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'New Nautilus Window'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'<Super>e'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'nautilus -w'"

#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "'New Kitty Terminal'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "'<Super>q'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "'kitty'"

#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "'1Password Quick Access'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "'<Shift><Control>space'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "'1password --quick-access'"

echo "enabling and starting user services"
systemctl --user --now enable pipewire-pulse
systemctl --user --now enable wireplumber

#echo "don't forget the following items:"
#echo "Gradience - set blueish Theme"

echo "configuring snapper"
sudo umount /.snapshots
sudo rm -rf /.snapshots

sudo snapper -c root create-config /

sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a
sudo chmod 750 /.snapshots
sudo chown :wheel /.snapshots


sudo vi /etc/mkinitcpio.conf

#Add the hook grub-btrfs-overlayfs at the end of HOOKS in /etc/mkinitcpio.conf ...

#HOOKS=(base ... fsck grub-btrfs-overlayfs)


sudo snapper -c root create -d "-- Baseinstall --"
