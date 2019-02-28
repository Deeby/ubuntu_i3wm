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

# Set up a firewall with basic configuration. Also check if ufw is installed. If it is not, then install it.
read -p "Press enter to proceed with firewall configuration: "
sudo apt install ufw -y
echo""
echo "Denying incoming connections."
sudo ufw default deny incoming > dev/null
echo "Allowing outgoing connections."
sudo ufw default allow outgoing > dev/null
echo "Starting the firewall"
sudo ufw enable > dev/null
sudo ufw status verbose
echo ""

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

# List applications to install, prompt the user to continue and proceed to install the applications.
echo "The following applications will now be installed."
echo "- compton"
echo "- mosh"
echo "- gedit"
echo "- bitwarden"
echo "- rhythmbox"
echo "- git"
echo "- virtualbox"
echo "- vagrant"
read -p "Press enter to continue: "
sudo apt install compton
sudo apt install mosh
sudo apt install gedit
sudo snap install bitwarden
sudo apt install rhythmbox
sudo apt install git
sudo apt install virtualbox
sudo apt install vagrant
echo

# Update the local database.
echo "Updating the local database."
sudo updatedb
echo

# Remove unecessary packages and clean up the system.
sudo apt autoremove
sudo apt autoclean

exit 0
