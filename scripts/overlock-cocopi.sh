#!/bin/bash

clear

echo "This script will enable overlock settings to the CoCo-Pi distribution."
echo
echo "If the CoCo-Pi does not boot correctly, power off the Raspberry Pi,"
echo "remove the SD card and open it on another computer.  Edit the 'config.txt'"
echo "file and comment out the overlock settings at the bottom of the file."
echo
echo "Insert the SD card back into the Raspberry Pi and you should be OK."
echo
echo
read -p "Press any key to continue or [CTRL-C] to abort..." -n1 -s
echo
echo

# detect model of Raspberry Pi
RPI=`cat /proc/device-tree/model | cut -c14-16`

if [ "$RPI" == "400" ]; then
        sudo cp /home/pi/update/config.txt.RPi400.overlock /boot/config.txt
fi

if [ "$RPI" == "4 M" ]; then
        sudo cp /home/pi/update/config.txt.RPi4.overclock /boot/config.txt
fi

if [ "$RPI" == "3 M" ]; then
        sudo cp /home/pi/update/config.txt.RPi3.overclock /boot/config.txt
fi

echo

echo
echo Please reboot to apply overclock settings.  Thank you.
echo
read -p "Press any key to continue... " -n1 -s

echo
echo Done!
echo
