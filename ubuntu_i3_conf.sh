#!/bin/bash

# This script installs the i3 window manager for ubuntu minimal 18.04.
# You can download ubuntu 18.04 minimal at (http://cdimages.ubuntu.com/netboot/)
# There is a config file included, use that for full compatibility.
# The config file in this repo should replace the one located at ~/.config/i3/config

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
clear
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
echo

# Set up a firewall with basic configuration. Also check if ufw is installed. If it is not, then install it.
read -p "Press enter to proceed with firewall configuration: "
clear
sudo apt install ufw -y
clear
echo "Denying incoming connections."
sudo ufw default deny incoming > /dev/null
echo "Allowing outgoing connections."
sudo ufw default allow outgoing > /dev/null
echo "Starting the firewall"
sudo ufw enable > /dev/null
echo
sudo ufw status verbose
echo ""

# Installation of i3 along with all needed software for functioning desktop.
echo "The following download is over 1GB in size."
echo "Make sure you have enough available data to install the necessary packages."
read -p "Press enter to install i3 along with all software for functioning desktop: "
clear
sudo apt install xorg xserver-xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings ubuntu-drivers-common mesa-utils mesa-utils-extra compton thunar git wicd feh i3 intel-microcode firefox lxappearance gtk-chtheme qt4-qtconfig xfce4-terminal unzip lm-sensors pulseaudio pnmixer pavumeter xbacklight imagemagick upower mosh gedit git virtualbox vagrant transmission software-properties-common openssh-server mosh steam arc-theme snapd i3blocks gnome-calculator engrampa vlc -y
sudo snap install bitwarden -y
echo

# Install themes 
#read -p "Press enter to download and install themes: "
#clear
#cd ~
#mkdir Downloads
#cd Downloads
#echo "Downloading themes."
#git clone https://github.com/tliron/install-gnome-themes
#cd install-gnome-themes
#./install-gnome-themes
#echo "Installation complete."
#cd ~

# Install Moka incons
read "Press enter to install Moka icons: "
clear
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt-get install moka-icon-theme faba-icon-theme faba-mono-icons

# Update the local database.
clear
echo "Updating the local database."
sudo updatedb
echo

# Remove unecessary packages and clean up the system.
echo "Removing unecessary packages."
sudo apt autoremove -y
sudo apt autoclean -y

exit 0
