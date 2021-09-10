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

# set hotfixes file
file="$HOME/update/cocopi-fixes.txt"
# create the file if it doesn't exist
touch $file


# update pyDriveWire
# check for fix
fix="fix-20210901-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/pydrivewirerc-daemon $HOME/pyDriveWire-namedobj/config
	cp $HOME/update/pydrivewirerc-daemon $HOME/pyDriveWire-release/config
	cp $HOME/update/start_pyDW.sh $HOME/pyDriveWire-namedobj
	cp $HOME/update/start_pyDW.sh $HOME/pyDriveWire-release
	echo "$fix" >>$file
	echo Please restart pyDriveWire to complete fix.  Thank you.
	echo
fi


# add sample source programs
# check for fix
fix="fix-20210901-02"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	tar xzf /home/pi/update/source-samples.tar.gz -C /
	echo "$fix" >>$file
	echo
fi


# add geany.conf file
# check for fix
fix="fix-20210901-03"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/geany.conf $HOME/.config/geany
	echo "$fix" >>$file
	echo
fi

# update pyDriveWire from git
# check for fix
fix="fix-20210901-04"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cd $HOME/pyDriveWire-namedobj
	./stop_pyDW.sh
	cd $HOME/pyDriveWire-namedobj
	git pull
	echo "$fix" >>$file
	echo Please restart pyDriveWire to complete fix.  Thank you.
	echo
fi


# add updated coco3dw1 cfg files for MAME
# check for fix
fix="fix-20210901-05"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/coco3dw1* $HOME/.mame/cfg
	echo "$fix" >>$file
	echo
fi


# add new font
# check for fix
fix="fix-20210902-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/CRYSTALR.TTF $HOME/.fonts
	fc-cache -v -f
	echo "$fix" >>$file
	echo
fi


# add Squanchy BASIC from Tim Lindner
# check for fix
fix="fix-20210903-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	unzip -o -j $HOME/update/Squanchy.zip -d /media/share1/SDC/TLINDNER
	echo "$fix" >>$file
	echo
fi


# add new packages
# check for fix
fix="fix-20210905-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	sudo apt install -y dos2unix dialog gnome-screenshot doublecmd-gtk
	echo "$fix" >>$file
	echo
fi


# add updated MAME launch scripts for CoCo
# check for fix
fix="fix-20210906-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/coco*.sh $HOME/.mame
	echo "$fix" >>$file
	echo
fi


# add new packages
# check for fix
fix="fix-20210908-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y zenity
        echo "$fix" >>$file
        echo
fi


# add new packages for remote desktop access
# check for fix
fix="fix-20210909-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y xrdp tightvncserver remmina remmina-common remmina-plugin-rdp
        sudo systemctl enable xrdp
        echo "$fix" >>$file
        echo
fi


# update pydrivewirerc-daemon config file
# check for fix
fix="fix-20210909-02"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/pydrivewirerc-daemon $HOME/pyDriveWire-namedobj/config
	cp $HOME/update/pydrivewirerc-daemon $HOME/pyDriveWire-release/config
	echo "$fix" >>$file
	echo Please restart pyDriveWire to complete fix.  Thank you.
	echo
fi


# update menus
# check for fix
fix="fix-20210910-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo

	if [ -f $HOME/.mame/menu ]
	then
    		rm $HOME/.mame/menu
	fi

	ln -s $HOME/.mame/CoCoPi-menu.sh $HOME/.mame/menu
	ln -s $HOME/.mame/CoCoPi-menu-Utilities.sh $HOME/.mame/utils
	echo "$fix" >>$file
	echo
fi


echo

echo
echo Please reboot as soon as possible so all updates can be applied.  Thank you.
echo
read -p "Press any key to continue... " -n1 -s

echo
echo Done!
echo
