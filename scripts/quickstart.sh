#!/bin/bash
# this script will bring Fedora 38 as close and as fast to your defaults as possible :)
# run this script right after installation. 
# this script assumes the following
# your home dir is /home/daniel
# you are able to use sudo
# you've ran dnf upgrade after installation - please do!
# you've placed the keyfile in /root/ (i'll not do that for you... that's way to risky)
# 
# Version 1.0
# 27. Juli 2023

# setting some variables
HOME=/home/daniel
BACKUP=/mnt/backup/July

echo "Welcome to the QuickStart Script. This script will use your Backup Disk to get your system as close to sane defaults as possible."
echo "Some settings can't be automated. These include:"
echo "- Subscription to other EWS Mailboxes inside Evolution"
echo "- Installing Appimage apps"
echo "- Login and Setup for the following apps: pCloud, Insync, Obsidian, Microsoft Edge and 1Password... basically everything that needs a web-aided login"
echo " "
echo "Please make sure that:"
echo "- you ran dnf upgrade and rebooted the PC"
echo "- you added /dev/mapper/backup      /mnt/backup ext4 noauto to fstab"
echo " "
read -p "press enter to continue or ctrl-c to bail now"

# adding backupdisk to fstab - this can't be automated
# sudo echo "/dev/mapper/backup      /mnt/backup ext4 noauto" >> /etc/fstab

# decrypting and mounting backup disk
echo "Decrypting and mounting backup disk"
sudo cryptsetup open /dev/disk/by-uuid/9cb445d1-e2e2-41a3-80a4-e9b042ff2465 backup --key-file /root/FPwofje
sudo mkdir /mnt/backup
sudo systemctl daemon-reload
sudo mount /mnt/backup


# add rpmfusion repos
echo "add rpmfusion repos"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# sublime-text
echo "add sublime-text"
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# anydesk
echo "add anydesk"
sudo tee /etc/yum.repos.d/anydesk.repo << "EOF" > /dev/null
[anydesk]
name=AnyDesk Stable
baseurl=http://rpm.anydesk.com/centos/${basearch}/
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
sudo rpm --import https://keys.anydesk.com/repos/RPM-GPG-KEY

# 1password
echo "add 1password"
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

# install dnf available software
echo "installing dnf available software"
sudo dnf install \
remmina \
krita \
kitty \
sublime-text \
apostrophe \
input-remapper \
1password \
zsh \
menulibre \
gnome-tweaks \
neofetch \
aspell-de \
geary \
evolution \
evolution-ews \
microsoft-edge-stable \
virt-manager \
util-linux-user \
seahorse \
anydesk

# insync
echo "download and install Insync"
cd $HOME/Downloads
wget https://cdn.insynchq.com/builds/linux/insync-3.8.6.50504-fc38.x86_64.rpm
sudo dnf install ./insync-3.8.6.50504-fc38.x86_64.rpm

# pureref
echo "copy and install PureRef"
cp $BACKUP/home/daniel/Apps/PureRef-1.11.1_x64.rpm $HOME/Downloads
cd $HOME/Downloads
sudo dnf install ./PureRef-1.11.1_x64.rpm

# nccm
echo "clone and install nccm"
cd $HOME/Downloads
git clone https://github.com/flyingrhinonz/nccm nccm.git
cd nccm.git/nccm/
sudo install -m 755 nccm -t /usr/local/bin/

# flatpak available software
echo "install flatpak apps"
flatpak install \
app/md.obsidian.Obsidian/x86_64/stable \
app/com.spotify.Client/x86_64/stable \
app/com.todoist.Todoist/x86_64/stable \
app/com.github.GradienceTeam.Gradience/x86_64/stable \
com.mattjakeman.ExtensionManager \
app/org.onlyoffice.desktopeditors/x86_64/stable \
com.microsoft.Edge \
-y

# copy config dirs back from backup
echo "copy config dirs"
cd $BACKUP/home/daniel/
cp -r .fonts \
.anydesk \
.icons \
.themes \
.oh-my-zsh \
.ssh \
Scripts \
ISOs \
$HOME/

cp -r \
.config/evolution \
.config/geary \
.config/gtk-3.0 \
.config/gtk-4.0 \
.config/input-remapper \
.config/kitty \
.config/remmina \
.config/sublime-text \
$HOME/.config/

cp -r \
.local/share/evolution \
.local/share/geary \
.local/share/krita \
.local/share/remmina \
.local/share/keyrings \
$HOME/.local/share/

cp -r \
.local/share/gnome-shell/extensions \
$HOME/.local/share/gnome-shell/

# copy config files back from backup
echo "copy config files"
cp \
.local/share/applications/kitty.desktop \
.local/share/applications/org.gnome.Nautilus.desktop \
$HOME/.local/share/applications/

cp \
.config/monitors.xml \
.config/kritarc \
.config/background \
$HOME/.config/

cp \
.zshrc \
.zsh_history \
.nccm.yml \
$HOME/

echo "copy gnome-shell extensions - THIS WILL REQUIRE A LOGOUT"
cp .local/share/gnome-shell/extensions $HOME/.local/share/gome-shell/

echo "copy AppImages from backup"
# copy select apps back from backup
mkdir $HOME/Apps
cp $BACKUP/home/daniel/Apps/pcloud $HOME/Apps

echo "update font cache"
# update font cache
fc-cache -v

# set sane gnome defaults
echo "setting gnome defaults"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.mutter center-new-windows 'true'
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace Regular 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 10'
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

# load extension settings
echo "load extension settings"
dconf load /org/gnome/shell/extensions/ < $BACKUP/home/daniel/Data/QuickStart/Fedora38-gnome-extensions.conf

# load evolution settings
echo "load evolution settings"
dconf load /org/gnome/evolution/ < $BACKUP/home/daniel/Data/QuickStart/Fedora38-evolution.conf

# activate extensions
echo "activating gnome extensions - THIS WILL WORK AFTER A REBOOT"
gsettings set org.gnome.shell disable-user-extensions 'false'
gsettings set org.gnome.shell disabled-extensions "['background-logo@fedorahosted.org']"
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'clipboard-indicator@tudmotu.com', 'color-picker@tuberry', 'CoverflowAltTab@palatis.blogspot.com', 'dash-to-dock@micxgx.gmail.com', 'gnome-ui-tune@itstime.tech', 'hibernate-status@dromi', 'hidetopbar@mathieu.bidon.ca', 'just-perfection-desktop@just-perfection', 'tiling-assistant@leleat-on-github', 'tophat@fflewddur.github.io', 'transparent-window-moving@noobsai.github.com', 'unblank@sun.wxg@gmail.com', 'unredirect@vaina.lt']"

# set fav apps
echo "setting dock icons"
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'microsoft-edge.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Evolution.desktop', 'org.gnome.Geary.desktop', 'obsidian.desktop', '1password.desktop', 'org.remmina.Remmina.desktop', 'com.spotify.Client.desktop', 'kitty.desktop', 'anydesk.desktop']"

# change default shell to zsh this will ask for a password
echo "change shell to zsh - this will prompt you for your password"
chsh -s $(which zsh)

# copy VMs back from backup
echo "sparsely rsyncing VMs back from Backup"
sudo rsync -av --sparse $BACKUP/var/lib/libvirt/images /var/lib/libvirt

# define VMs
echo "defining VMs"
cd $BACKUP/home/daniel/VMExports
for vm in `find ./*.xml`; do sudo virsh define $vm; done

# unmount backup disk
echo "unmounting and closing backup disk"
sudo umount /mnt/backup
sudo cryptsetup close backup

# best to restart the machine
while true; do
    read -p "done - I'd like to reboot the machine now. OK? if you say 'n/N' i'll just exit and leave you too it" yn
    case $yn in
        [Yy]* ) sudo reboot;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


