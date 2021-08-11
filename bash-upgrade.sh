#!/bin/bash

## Custom upgrade script I created to automatically for updates across the system
## Created by Joshua Kimsey
## Released under a Creative Commons 1.0 License to the Public Domain
## Customize it and use it as you wish! :)

# Announce start of upgrade script and get sudo permissions from user
# Probably not the best way to get a user's sudo permissions... But it works!
echo STARTING UPGRADE...; 
echo GETTING SUPERUSER PERMISSIONS; 
sudo echo;  

# Update APT repositories, Show user available updates  and let them agree to upgrade, then auto remove old/unused packages
# Probably should also be an if statement to see if APT exists, but I'm too lazy... Maybe someday
echo CHECKING REPOSITORIES;  
sudo apt update; 
echo CHECKING POTENTIAL UPGRADES; 
sudo apt full-upgrade; 
echo REMOVING OLD PACKAGES; 
sudo apt autoremove -y; 

# Check if Flatpak is installed and then check for updates, which the user must agree to, then uninstall old versions
if command -v flatpak &> /dev/null
then
	echo CHECKING FOR FLATPAK UPDATES; 
	flatpak update; 
	echo REMOVING OLD FLATPAK PACKAGES; 
	flatpak -y uninstall --unused; 
else
	echo 'Flatpak is not installed. Skipping...'
fi

# Check if Snap is installed and then update snaps
if command -v snap &> /dev/null
then
	echo CHECKING FOR SNAP UPDATES; 
	sudo snap refresh; 
else
	echo 'Snap is not installed. Skipping...';
fi

#Announce end of script
echo UPGRADING COMPLETE!
