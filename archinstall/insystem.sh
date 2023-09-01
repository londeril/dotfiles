#!/bin/sh
# run this on the freshly installed system
echo "creating user dirs"
mkdir /home/daniel/Downloads
mkdir /home/daniel/Documents
mkdir /home/daniel/Pictures
mkdir /home/daniel/Pictures/Screenshots
mkdir /home/daniel/Pictures/Wallpapers
mkdir /home/daniel/Pictures/ScreensaverPics
mkdir /home/daniel/Data
mkdir /home/daniel/.dotfiles
mkdir /home/daniel/.config

echo "copy configs in place and symlinking them"
#cp -r blah or maybe even tar xfv blah /home/daniel/.dotfiles/
ln -s ~/.dotfiles/hypr ~/.config/
ln -s ~/.dotfiles/zsh ~/.config/
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

echo "copy fonts"
# cp fonts
fc-cache -fv

echo "setting sensible defaults for gnome apps"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'


echo "installing yay"
cd /home/daniel/Downloads
git clone https://aur.archlinux.org/yay-bin
cd yay
makepkg -si

echo "getting neede packages from the AUR"
yay -S

echo "installing flatpaks"
flatpak install \
com.github.GradienceTeam.Gradience \
com.github.tchx84.Flatseal \
com.mattjakeman.ExtensionManager \
com.microsoft.Edge \
com.parsecgaming.parsec \
com.rtosta.zapzap \
com.spotify.Client \
com.todoist.Todoist \
com.valvesoftware.Steam \
org.onlyoffice.desktopeditors \
-y
