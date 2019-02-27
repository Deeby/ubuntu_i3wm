#!/bin/bash

# This script installs the i3 window manager for ubuntu minimal 18.04.
# You can install ubuntu 18.04 minimal at (http://cdimages.ubuntu.com/netboot/)

# Install i3 along with all needed packages
echo "This script will install the i3 window manager."
echo "Note that this script has been tested on Ubuntu minimal 18.04."
echo

# Test if internet connection is available
WEBCHEK=$(ping -c1 google.com)
if [[ ${?} -ne '0' ]]
then 
  echo "You are not online."
  echo "Run this script when connected to the internet."
  exit 1
fi

# Check if the user is root
USER_NAME=$(id -un)
if [[ ${UID} -ne '0' ]]
then
  echo "You are not root."
  echo "Your username is ${USER_NAME}"
  echo "Your UID is ${UID}"
  echo "Run this script as root or use sudo."
  exit 1
fi

# Updates and upgrades packages.
read -p "Press enter to update and upgrade system: "
echo
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y

# Installation of i3 along with all needed software for functioning desktop.
read -p "Press enter to install i3: "
echo
sudo apt install xorg xserver-xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings ubuntu-drivers-common mesa-utils mesa-utils-extra compton thunar git wicd feh i3 intel-microcode firefox lxappearance gtk-chtheme qt4-qtconfig xfce4-terminal unzip lm-sensors pulseaudio pnmixer pavumeter

# Install themes 
read -p "Press enter to download and install themes: "
mkdir Downloads
cd Downloads
git clone https://github.com/tliron/install-gnome-themes
cd install-gnome-themes
./install-gnome-themes
cd ~

# Below are commands to add to i3 config file
clear
echo "Add these commands to the bottom of the i3 config file."
echo '~/.config/i3/config'
echo
echo 'exec_always compton -b'
echo 'exec_always wicd-client --tray'
echo 'exec_always volumeicon'
echo 'exec firefox'
echo
echo 'bindsym $mod+shift+x exec i3lock'
echo
echo 'bindsym $mod+shift+p exec --no-startup-id pactl --set-sink-volume 0 +5% #increase sound volume'
echo 'bindsym $mod+shift+o exec --no-startup-id pactl --set-sink-volume 0 -5% #decrease sound volume'
echo 'bindsym $mod+shift+m exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound'
echo
echo 'bindsym $mod+shift+i exec xbacklight -inc 20 # increase screen brightness'
echo 'binsdym $mod+shift+u exec xbacklight -dec 20 # decrease screen brightness'
echo
read -p "Press enter to exit the script: "
exit 0









