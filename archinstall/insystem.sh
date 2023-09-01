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
mkdir ~/.dotfiles
mkdir ~/.config

echo "copy configs in place and symlinking them"
#cp -r blah or maybe even tar xfv blah ~/.dotfiles/
ln -s ~/.dotfiles/hypr ~/.config/
ln -s ~/.dotfiles/zsh ~/.config/
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/kitty ~/.config/
ln -s ~/.dotfiles/waybar ~/.config/
ln -s ~/.dotfiles/fuzzel ~/.config/

echo "copy fonts"
# cp fonts
fc-cache -fv

echo "installing yay"
cd ~/Downloads
git clone https://aur.archlinux.org/yay-bin
cd yay
makepkg -si

echo "adding 1password keys"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

echo "installing VMware Remote Console - fist yay run will fail... this's expected"
yay -S vmware-vmrc
cp ~/archinstall/vmrc/* ~/.cache/yay/vmware-vmrc/
yay -S vmware-vmrc

echo "getting neede packages from the AUR"
yay -S sublime-text-4 1password anydesk-bin pcloud insync

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

# settings default browser to firefox
xdg-settings set default-web-browser firefox.desktop

echo "don't forget the following items:"
echo "printer - nsswitch.conf"