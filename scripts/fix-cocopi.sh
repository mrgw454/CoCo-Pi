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

# install new MAME .cfg files

# check to see if new MAME cfg files have already been installed
#if [ -e $HOME/.mame/cfg/cfg-installed-20210814.txt ]
#then
#       echo new MAME cfg files already installed
#       echo
#else

#       echo installing new MAME cfg files...
#       cp $HOME/update/*cfg* $HOME/.mame/cfg
#       touch $HOME/.mame/cfg/cfg-installed-20210814.txt
#       echo
#fi


# add new programs from source

# check to see if libagar libraries have already been installed
#if [ -e $HOME/source/libagar-installed.txt ]
#then
#	echo libagar library already installed
#	echo
#else

#	cd $HOME/source/libagar
#	sudo make install
#	touch $HOME/source/libagar-installed.txt
#fi

#echo


# add sample source programs
# check to see if already installed

if [ -e /media/share1/source/source-installed.txt ]
then
       echo Sample source programs already installed
       echo
else

       tar xzf /home/pi/update/source-samples.tar.gz -C /
       touch /media/share1/source/source-installed.txt
fi

echo


# disable "excute" prompt in file manager
#sed -i 's/quick_exec=0/quick_exec=1/' $HOME/.config/libfm/libfm.conf

# remove "&" from web link address
#sed -i 's/\&//' "$HOME/Desktop/pyDriveWire Web UI.desktop"

# set symbolic link for correct HDD image
#rm /media/share1/EMU/VHD/HDD.DSK
#ln -s /media/share1/EMU/VHD/DECBVHD.img /media/share1/EMU/VHD/HDD.DSK


echo

echo
echo Please reboot as soon as possible so all updates can be applied.  Thank you.
echo
read -p "Press any key to continue... " -n1 -s

echo
echo Done!
echo
