#!/bin/bash

clear

echo "This script will resolve any minor issues that need to be addressed for the CoCo-Pi distribution."
echo
read -p "Press any key to continue or [CTRL-C] to abort..." -n1 -s
echo
echo

backupdate=$(date +"%Y%m%d_%H%M%S")

# detect model of Raspberry Pi
RPI=`cat /proc/device-tree/model | cut -c14-16`

if [ "$RPI" == "400" ]; then
        sudo cp /home/pi/update/config.txt.RPi400 /boot/config.txt
fi

if [ "$RPI" == "4 M" ]; then
        sudo cp /home/pi/update/config.txt.RPi4 /boot/config.txt
fi

if [ "$RPI" == "3 M" ]; then
        sudo cp /home/pi/update/config.txt.RPi3 /boot/config.txt
fi

echo

# add new packages
#sudo apt install -y <package>
sudo apt install -y hexchat
sudo apt install -y libao-dev libdbus-1-dev
sudo apt install -y qttools5-dev
sudo apt install -y cmake
sudo apt install -y qmmp
sudo apt install -y xdotool wmctrl
sudo apt install -y gvidm
sudo apt install -y mesa-utils
sudo apt install -y python3-png python-png
sudo apt install -y xclip

# add new programs from source

# check to see if libagar libraries have already been installed
if [ -e $HOME/source/libagar-installed.txt ]
then
	echo libagar library already installed
	echo
else

	cd $HOME/source/libagar
	sudo make install
	touch $HOME/source/libagar-installed.txt
fi

echo

# check to see if vgmplay has already been installed
if [ -e $HOME/source/vgmplay-installed.txt ]
then
	echo vgmplay already installed
	echo
else

	cd $HOME/source/vgmplay/VGMPlay
	sudo make install
	touch $HOME/source/vgmplay-installed.txt
fi

echo

# check to see if libvgm libraries have already been installed
if [ -e $HOME/source/libvgm-installed.txt ]
then
	echo libvgm library already installed
	echo
else

	cd $HOME/source/libvgm/build
	sudo make install
	touch $HOME/source/libvgm-installed.txt
fi

echo

# disable "excute" prompt in file manager
sed -i 's/quick_exec=0/quick_exec=1/' $HOME/.config/libfm/libfm.conf

# remove "&" from web link address
sed -i 's/\&//' "$HOME/Desktop/pyDriveWire Web UI.desktop"

echo

echo
echo Please reboot as soon as possible so all updates can be applied.  Thank you.
echo
read -p "Press any key to continue... " -n1 -s

echo
echo Done!
echo

