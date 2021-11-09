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


# update OVCC ini file for YA-DOS
# check for fix
fix="fix-20210917-01"
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

	cp $HOME/update/coco3-yados-HD-6309-mpi-OVCC.ini $HOME/.ovcc/ini
	cp $HOME/update/backupEMUConfigs-2021-09-17.tar.gz /media/share1
	echo "$fix" >>$file
	echo
fi


# update menus
# check for fix
fix="fix-20210917-02"
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

	if [ -f $HOME/.mame/utils ]
	then
    		rm $HOME/.mame/utils
	fi

	ln -s $HOME/.mame/CoCoPi-menu.sh $HOME/.mame/menu
	ln -s $HOME/.mame/CoCoPi-menu-Utilities.sh $HOME/.mame/utils
	echo "$fix" >>$file
	echo
fi


# get coco-hash project from git
# check for fix
fix="fix-20210917-03"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cd $HOME/source
	git clone https://github.com/mrgw454/coco-hash.git
	echo "$fix" >>$file
	echo
fi


# add new packages
# check for fix
fix="fix-20210917-04"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	sudo apt install -y rhash
	echo "$fix" >>$file
	echo
fi


# update MAME ini file for software hash
# check for fix
fix="fix-20210917-05"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo

	if [ "$RPI" == "400" ]; then
        	cp $HOME/update/mame.ini.RPi400 $HOME/.mame/mame.ini
	fi

	if [ "$RPI" == "4 M" ]; then
		cp $HOME/update/mame.ini.RPi4 $HOME/.mame/mame.ini
	fi

	if [ "$RPI" == "3 M" ]; then
		cp $HOME/update/mame.ini.RPi3 $HOME/.mame/mame.ini
	fi

        echo "$fix" >>$file
        echo
fi


# add sample programs for use with SuperSprite FM+ Board
# check for fix
fix="fix-20210929-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
        tar xzvf $HOME/update/MSX2.tar.gz -C /
	echo "$fix" >>$file
	echo
fi


# add new packages
# check for fix
fix="fix-20211008-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y timelimit
        echo "$fix" >>$file
        echo
fi


# get latest QB64 package (compiled from git)
# check for fix
fix="fix-20211012-02"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
	tar xzvf $HOME/update/QB64-2.0-compiled.tar.gz -C /
	cp $HOME/update/QB64-2.0.desktop $HOME/Desktop
        echo "$fix" >>$file
        echo
fi


# add new rclone package (cloud drive access)
# check for fix
fix="fix-20211014-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cd $HOME/source
	wget https://downloads.rclone.org/v1.56.2/rclone-v1.56.2-linux-arm-v7.deb
	sudo dpkg -i rclone-v1.56.2-linux-arm-v7.deb
	cp $HOME/update/rclone.png $HOME/Pictures
	cp "$HOME/update/rclone GUI.desktop" $HOME/Desktop
	echo "$fix" >>$file
	echo
fi


# add mc10.rom for latest XRoar
# check for fix
fix="fix-20211024-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	cp $HOME/update/mc10.rom /media/share1/roms
	echo "$fix" >>$file
	echo
fi


# install Visual Studio Code and some extensions
# check for fix
fix="fix-20211026-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	mkdir $HOME/source/code
	cp $HOME/update/code_1.61.2-1634655444_armhf.deb $HOME/source/code
	cp $HOME/update/blairleduc.6x09-assembly-0.6.7.vsix $HOME/source/code
	cp $HOME/update/jasonpittman.cocotools-0.0.8.vsix $HOME/source/code
	cp $HOME/update/Tandy.6x09-assembly-0.1.0.vsix $HOME/source/code
	cp $HOME/update/Tandy.color-basic-0.1.4.vsix $HOME/source/code
	cp $HOME/update/code.desktop $HOME/Desktop
				
	cd $HOME/source/code
	sudo dpkg -i code_1.61.2-1634655444_armhf.deb
	code --install-extension $HOME/source/code/Tandy.6x09-assembly-0.1.0.vsix
	code --install-extension $HOME/source/code/Tandy.color-basic-0.1.4.vsix
	code --install-extension $HOME/source/code/jasonpittman.cocotools-0.0.8.vsix
	code --install-extension $HOME/source/code/blairleduc.6x09-assembly-0.6.7.vsix
				
	echo "$fix" >>$file
	echo
fi


# add new library package and updated cecb from Toolshed project
# check for fix
fix="fix-20211027-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	sudo apt-get install libfuse-dev
	sudo cp $HOME/update/cecb /usr/bin
	echo "$fix" >>$file
	echo
fi


# add new build command for geany
# check for fix
fix="fix-20211027-02"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	sed -i "s/number_exec_menu_items=10/number_exec_menu_items=12/" /home/pi/.config/geany/geany.conf
	tar xzf /home/pi/update/source-samples-mc10.tar.gz -C /
	echo "$fix" >>$file
	echo
fi


# update menu symlink
# check for fix
fix="fix-20211028-01"
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
        echo "$fix" >>$file
        echo
fi


# update menu symlink
# check for fix
fix="fix-20211028-02"
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
        echo "$fix" >>$file
        echo
fi


# add new build commands for geany
# check for fix
fix="fix-20211108-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	sed -i "s/number_exec_menu_items=12/number_exec_menu_items=16/" /home/pi/.config/geany/geany.conf
	tar xzf /home/pi/update/source-samples-mc10.tar.gz -C /
	echo "$fix" >>$file
	echo
fi


# add vbcc compiler
# check for fix
fix="fix-20211109-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xzf /home/pi/update/vbcc-20210903.tar.gz -C /
	cp $HOME/update/HOWTO-vbcc.txt $HOME/source
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
