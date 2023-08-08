#!/bin/bash

clear

echo "This script will resolve any minor issues that need to be addressed for the CoCo-Pi distribution."
echo
read -p "Press any key to continue or [CTRL-C] to abort..." -n1 -s
echo
echo

backupdate=$(date +"%Y%m%d_%H%M%S")

if [ -e "$HOME/update/.fix-cocopi-skip-config-clobber" ]; then
	echo "Skipping update of /boot/config.txt - If you want this update then go to the Utilities->Administration menu and select Toggle Raspberry PI config.txt updates"
	echo
	read -p "Press any key to continue... " -n1 -s
	echo
else

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


# add sample programs for use with SuperSprite FM+ Board
# check for fix
fix="fix-20211116-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xzvf $HOME/update/MSX2-CoCo2.tar.gz -C /
        echo "$fix" >>$file
        echo
fi


# add new packages required for Mike Rowan's printer project
# check for fix
fix="fix-20211116-02"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y inotify-tools cups
	sudo usermod -aG lpadmin pi
	sudo cupsctl --remote-any
        echo "$fix" >>$file
        echo
fi


# add new packages
# check for fix
fix="fix-20211117-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y figlet jp2a toilet asciio

	cd /home/pi/source/tasm6801
	rm src/tasm6801
	git pull
	cd src
	c++ *.cpp -o tasm6801
	sudo cp tasm6801 /usr/local/bin
	sudo ln -s /usr/local/bin/tasm6801 /usr/local/bin/tasm

	cd /home/pi/source/mcbasic
	make clean
	git pull
	cp $HOME/update/Makefile.mcbasic $HOME/source/mcbasic/src/Makefile
	make
	sudo cp mcbasic /usr/local/bin

        echo "$fix" >>$file
        echo
fi


# add new mcbasic package
# check for fix
fix="fix-20211119-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo

        cd /home/pi/source/mcbasic
        make clean
	rm /home/pi/source/mcbasic/mcbasic
	rm /home/pi/source/mcbasic/src/mcbasic
        cp $HOME/update/coreimplementation.cpp $HOME/source/mcbasic/src
        cp $HOME/update/coretarget.cpp $HOME/source/mcbasic/src
        make
        sudo cp mcbasic /usr/local/bin

        echo "$fix" >>$file
        echo
fi


# add new cas2wav package
# check for fix
fix="fix-20211119-02"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo

        cp $HOME/update/cas2wav-0.8.tar.gz $HOME/source
        cd /home/pi/source
	tar zxvf cas2wav-0.8.tar.gz
	cd cas2wav-0.8
	make
        sudo cp cas2wav /usr/local/bin

        echo "$fix" >>$file
        echo
fi


# add new cmoc package
# check for fix
fix="fix-20211120-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
	sudo apt install -y gawk
	sudo apt remove -y cmoc
        tar xvf $HOME/update/cmoc-0.1.72-CoCoPi.tar.gz -C /
        cd $HOME/source/cmoc-0.1.72
	sudo make install

        echo "$fix" >>$file
        echo
fi


# get DECB Preprocessor project from git
# check for fix
fix="fix-20211120-02"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        cd $HOME/source
        git clone https://github.com/yggdrasilradio/preprocessor.git
	cd $HOME/source/preprocessor
	sudo cp decbpp /usr/local/bin
        cp basic.vim ~/.vim/syntax/basic.vim
        echo "$fix" >>$file
        echo
fi


# install screen recorder utilities
# check for fix
fix="fix-20211123-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y vlc-plugin-access-extra simplescreenrecorder

        echo "$fix" >>$file
        echo
fi


# update build commands for geany
# check for fix
fix="fix-20211123-02"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sed -i "s/number_exec_menu_items=16/number_exec_menu_items=24/" /home/pi/.config/geany/geany.conf
        echo "$fix" >>$file
        echo
fi


# add source for Greg Dionne's MC-10 Java emulator
# check for fix
fix="fix-20211202-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo

	if [ -d $HOME/source/mc-10 ]
       	then
                	rm -r -f $HOME/source/mc-10
        fi

        tar xzf /home/pi/update/gd-mc10.tar.gz -C /
        echo "$fix" >>$file
        echo
fi


# add new packages
# check for fix
fix="fix-20211209-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y socat
        echo "$fix" >>$file
        echo
fi


# add new public domain CoCo cart files
# check for fix
fix="fix-20211220-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        cp $HOME/update/*.ccc /media/share1/carts
        echo "$fix" >>$file
        echo
fi


# add new packages for playsound extension (pyDW)
# check for fix
fix="fix-20211221-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y python-gi gstreamer1.0-tools gir1.2-gstreamer-1.0 gir1.2-gst-plugins-base-1.0 gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-plugins-bad gstreamer1.0-libav libgirepository1.0-dev
        pip install playsound
  	sudo patch -p1 -d /home/pi/.local/lib/pypy2.7/site-packages/pip/_internal/operations/install <$HOME/update/pygobject-install.patch
	pypy -m pip install pygobject
	pypy -m pip install playsound
	sudo patch -R -p1 -d /home/pi/.local/lib/pypy2.7/site-packages/pip/_internal/operations/install <$HOME/update/pygobject-install.patch
        echo "$fix" >>$file
        echo
fi


# add new converions utilities from Tormod Volden
# check for fix
fix="fix-20212123-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xzf /home/pi/update/conv-tools.tar.gz -C /
	sudo cp $HOME/source/conv-tools/cas2decb /usr/local/bin
	sudo cp $HOME/source/conv-tools/ddb2decb /usr/local/bin
	sudo cp $HOME/source/conv-tools/decb2ddb /usr/local/bin
	sudo cp $HOME/source/conv-tools/image-patcher /usr/local/bin
	sudo cp $HOME/source/conv-tools/pad256 /usr/local/bin
        echo "$fix" >>$file
        echo
fi


# update pyDriveWire from git
# check for fix
fix="fix-20211226-01"
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
	cp $HOME/.pydrivewirerc $HOME/.pydrivewirerc.backup.$backupdate
	cp $HOME/update/.pydrivewirerc.playsound $HOME/.pydrivewirerc
	cp $HOME/update/coco-playsound.dsk /media/share1/DW4/FURMAN
        echo "$fix" >>$file
        echo Please restart pyDriveWire to complete fix.  Thank you.
        echo
fi


# add updated coco2h cfg files for MAME (SSFM attract mode)
# check for fix
fix="fix-20220109-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        cp $HOME/update/coco2h.cfg.SSFM-enabled $HOME/.mame/cfg
        echo "$fix" >>$file
        echo
fi


# add updated mame-0.238 binary with video fix for SSFM support
# special thanks to Nigel Barnes
# check for fix
fix="fix-20220109-02"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo unzip -o -j $HOME/update/mame-0.239-SSFM-fix.zip -d /opt/mame-0.239
	sudo mv /opt/mame-0.239/mame-0.239-SSFM-fix /opt/mame/mame
        echo "$fix" >>$file
        echo
fi


# add new packages
# check for fix
fix="fix-20220131-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y libxpm-dev
        echo "$fix" >>$file
        echo
fi


# add new packages
# check for fix
fix="fix-20220202-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y internetarchive
        echo "$fix" >>$file
        echo
fi


# add Microsoft TrueType font package
# check for fix
fix="fix-20220223-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        cd $HOME/update
        sudo dpkg -i ttf-mscorefonts-installer_3.8_all.deb
        echo "$fix" >>$file
        echo
fi


# update tasm6801 and mcbasic compiler
# check for fix
fix="fix-20220224-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo

	if [ "$RPI" == "3 M" ]; then

        	sudo cp $HOME/update/mcbasic /usr/local/bin
        	sudo cp $HOME/update/tasm6801 /usr/local/bin

	else

        	cd /home/pi/source/tasm6801
        	rm src/tasm6801
        	git pull
        	cd src
        	c++ *.cpp -o tasm6801
        	sudo cp tasm6801 /usr/local/bin

        	cd /home/pi/source/mcbasic
        	rm mcbasic
		make clean
        	git reset --hard
		git pull
        	sed -i 's/-ferror-limit=4 //' src/Makefile
        	make
        	sudo cp mcbasic /usr/local/bin
	fi

        echo "$fix" >>$file
        echo
fi


# fix mame.ini video setting for MAME-0.241 and above
# check for fix
fix="fix-20220228-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        cd $HOME/.mame

	sed -i 's/video                     auto/video                     accel/' mame.ini

        echo "$fix" >>$file
        echo
fi


# get latest QB64-2.0.2 package (compiled with patches from George McGinn)
# check for fix
fix="fix-20220313-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
	wget -c -P $HOME/update http://rickadams.org/ronklein/qb64-2.0.2-George-McGinn-patched.tar.gz
	wget -c -P $HOME/update http://rickadams.org/ronklein/qb64-2.0.2-George-McGinn-patched.tar.gz.md5

	cd $HOME/update

		if md5sum -c $HOME/update/qb64-2.0.2-George-McGinn-patched.tar.gz.md5; then

    			echo -e
    			echo -e "Download was successful.  File passed MD5 checksum."
    			echo -e
    			echo -e "Extracting files into $HOME/source..."
    			echo -e
    			tar xzvf $HOME/update/qb64-2.0.2-George-McGinn-patched.tar.gz -C /
    			echo -e
    			echo -e "Done!"
    			echo -e
			echo "$fix" >>$file

		else

    			echo -e
    			echo -e "Download was unsuccessful.  File did not pass MD5 checksum."
    			echo -e
    			echo -e "Aborting."
    			echo -e
    			read -p "Press any key to continue." -n1 -s

		fi

        echo
fi


# add NitrOS9 EOU empty user hard drive image
# check for fix
fix="fix-20220317-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        unzip -o -j $HOME/update/EOU_USER_empty_harddrive.zip -d /media/share1/EMU/EOU
        echo "$fix" >>$file
        echo
fi


# add new cmoc package
# check for fix
fix="fix-20220504-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xvf $HOME/update/cmoc-0.1.77-CoCoPi.tar.gz -C /
        cd $HOME/source/cmoc-0.1.77
        sudo make install

        echo "$fix" >>$file
        echo
fi


# update pyDriveWire
# check for fix
fix="fix-20220518-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
	cd $HOME
	git clone https://github.com/n6il/pyDriveWire.git pyDriveWire-playsound
	cd $HOME/pyDriveWire-playsound
	git checkout playsound
	git pull

	cp $HOME/update/.pydrivewirerc.playsound $HOME/pyDriveWire-playsound/config/pydrivewirerc-daemon
        cp $HOME/update/start_pyDW.sh $HOME/pyDriveWire-playsound
        cp $HOME/update/stop_pyDW.sh $HOME/pyDriveWire-playsound
        cp $HOME/update/status_pyDW.sh $HOME/pyDriveWire-playsound
        cp $HOME/update/pyDW.sh $HOME/pyDriveWire-playsound

	echo
	echo "This will take some time.  Please be patient."
	echo

	sudo patch -p1 -d /home/pi/.local/lib/pypy2.7/site-packages/pip/_internal/operations/install <$HOME/update/pygobject-install.patch
	pypy -m pip install paramiko
	sudo patch -R -p1 -d /home/pi/.local/lib/pypy2.7/site-packages/pip/_internal/operations/install <$HOME/update/pygobject-install.patch

	echo
	echo "If the paramiko module failed, please contact support for CoCo-Pi in the #coco-pi channel Discord."
	echo
	read -p "Press any key to continue... " -n1 -s
	echo

        echo "$fix" >>$file
        echo "Please select pyDriveWire-playsound from the Utilities / Drive Emulation Menu as the default version to use."
        echo
fi


# update Greg Dionne's Java MC-10 emulator from git
# check for fix
fix="fix-20220612-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        cd $HOME/source

       if [ -d $HOME/source/mc-10 ]
       then
       		rm -r -f $HOME/source/mc-10
       fi

	git clone https://github.com/gregdionne/mc-10.git
	cd $HOME/source/mc-10
	git checkout cassette
	git pull

	cp $HOME/update/mc10.css $HOME/source/mc-10/MC10

        echo "$fix" >>$file
        echo
fi


# update OVCC to 1.5.1
# check for fix
fix="fix-20220617-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xzf /home/pi/update/OVCC-1.5.1-CoCoPi.tar.gz -C /
        echo "$fix" >>$file
        echo
fi


# add cocofs disk utility from github
# check for fix
fix="fix-20220706-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xzf /home/pi/update/cocofs-20220706.tar.gz -C /
	sudo cp /home/pi/source/cocofs/cocofs /usr/local/bin
        echo "$fix" >>$file
        echo
fi


# add new cmoc package
# check for fix
fix="fix-20220828-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xvf $HOME/update/cmoc-0.1.79-CoCoPi.tar.gz -C /
        cd $HOME/source/cmoc-0.1.79
        sudo make install

        echo "$fix" >>$file
        echo
fi


# add new packages
# check for fix
fix="fix-20221002-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        sudo apt install -y libqt5charts5-dev
	sudo cp $HOME/update/seergdb /usr/local/bin
	sudo cp $HOME/update/seergdb.desktop $HOME/Desktop
	sudo cp $HOME/update/seergdb /usr/local/bin
        echo "$fix" >>$file
        echo
fi


# add new RVPN programs and remote support capability
# check for fix
fix="fix-20230118-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        rm -rf /home/pi/rvpn
        tar xzf /home/pi/update/cocopi_support-2023-01-18.tar.gz -C /
	sudo ln -s /home/pi/rvpn/rvpn /usr/local/bin/rvpn
        echo "$fix" >>$file
        echo
fi


# add new cmoc package
# check for fix
fix="fix-20230206-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xvf $HOME/update/cmoc-0.1.81-CoCoPi.tar.gz -C /
        cd $HOME/source/cmoc-0.1.81
        sudo make install

        echo "$fix" >>$file
        echo
fi


# update pyDriveWire
# check for fix
fix="fix-20230308-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
	cd $HOME
	cp $HOME/.pydrivewirerc $HOME/.pydrivewirerc.backup
		
	git clone https://github.com/n6il/pyDriveWire.git pyDriveWire-git
	cd $HOME/pyDriveWire-git
	git checkout master
	git pull

	cp $HOME/.pydrivewirerc.backup $HOME/pyDriveWire-git/config/pydrivewirerc-daemon
    cp $HOME/update/start_pyDW.sh $HOME/pyDriveWire-git
    cp $HOME/update/stop_pyDW.sh $HOME/pyDriveWire-git
    cp $HOME/update/status_pyDW.sh $HOME/pyDriveWire-git
    cp $HOME/update/pyDW.sh $HOME/pyDriveWire-git


    echo "$fix" >>$file
    echo "Please select pyDriveWire-git from the Utilities / Drive Emulation Menu as the default version to use."
    echo
fi


# add ugBasic and supporting components
# check for fix
fix="fix-20230308-02"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/bison-3.8.2-CoCoPi.tar.gz -C /
    tar xzf /home/pi/update/ugBasic-git-CoCoPi.tar.gz -C /
    tar xzf /home/pi/update/geany-filedefs-CoCoPi.tar.gz -C /

	sudo apt -y remove bison libbison-dev

	cd $HOME/source/bison-3.8.2
	sudo make install
	
	cd $HOME/source/ugbasic/ugbc/exe
	sudo cp ugbc.coco /usr/local/bin
	sudo cp ugbc.d64 /usr/local/bin
	sudo cp ugbc.d32 /usr/local/bin

	cd $HOME

    echo "$fix" >>$file
    echo
fi


# update ugBasic
# check for fix
fix="fix-20230210-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/ugBasic-git-20230210-CoCoPi.tar.gz -C /

	cd $HOME/source/ugbasic/ugbc/exe
	sudo cp ugbc.coco /usr/local/bin
	sudo cp ugbc.d64 /usr/local/bin
	sudo cp ugbc.d32 /usr/local/bin

	cd $HOME

    echo "$fix" >>$file
    echo
fi


# install autoconf from source and update ugBasic
# check for fix
fix="fix-20230523-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/autoconf-2.71.tar.gz -C /home/pi/source

	cd $HOME/source/autoconf-2.71
	./configure
	make
	sudo make install

       if [ -d $HOME/source/ugbasic ]
       then
       		rm -r -f $HOME/source/ugbasic
       fi

	tar xzf /home/pi/update/ugBasic-git-20230523-CoCoPi.tar.gz -C /

	cd $HOME/source/ugbasic/ugbc/exe
	sudo cp ugbc.coco /usr/local/bin
	sudo cp ugbc.d64 /usr/local/bin
	sudo cp ugbc.d32 /usr/local/bin

	cd $HOME

    echo "$fix" >>$file
    echo
fi


# add new cmoc package
# check for fix
fix="fix-20230524-01"
if grep -q "$fix" $file; then
        echo fix $fix already complete.
        echo
else
        echo Applying fix $fix...
        echo
        tar xvf $HOME/update/cmoc-0.1.82-CoCoPi.tar.gz -C /
        cd $HOME/source/cmoc-0.1.82
        sudo make install

        echo "$fix" >>$file
        echo
fi


# add trs80gp emulator
# check for fix
fix="fix-20230605-01"
if grep -q "$fix" $file; then
	echo fix $fix already complete.
	echo
else
	echo Applying fix $fix...
	echo
	sudo cp $HOME/update/trs80gp /usr/local/bin
	sudo chmod a+x /usr/local/bin/trs80gp

	tar xvf $HOME/update/trs80gp.tar.gz -C /
	
	echo "$fix" >>$file
fi


# update ugBasic
# check for fix
fix="fix-20230606-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/ugBasic-git-20230606-CoCoPi.tar.gz -C /

	cd $HOME/source/ugbasic/ugbc/exe
	sudo cp ugbc.coco /usr/local/bin
	sudo cp ugbc.d64 /usr/local/bin
	sudo cp ugbc.d32 /usr/local/bin

	cd $HOME

    echo "$fix" >>$file
    echo
fi


# add Frank Hogg's Color FLEX option for XRoar
# check for fix
fix="fix-20230609-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/color-flex-5.0.4-frank-hogg-laboratory.tar.gz -C /

    echo "$fix" >>$file
    echo
fi


# update ugBasic
# check for fix
fix="fix-20230617-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/ugBasic-git-20230617-CoCoPi.tar.gz -C /

        cd $HOME/source/ugbasic/ugbc/exe
        sudo cp ugbc.coco /usr/local/bin
        sudo cp ugbc.d64 /usr/local/bin
        sudo cp ugbc.d32 /usr/local/bin

        cd $HOME

    echo "$fix" >>$file
    echo
fi


# update ugBasic
# check for fix
fix="fix-20230618-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/ugBasic-git-20230618-CoCoPi.tar.gz -C /

        cd $HOME/source/ugbasic/ugbc/exe
        sudo cp ugbc.coco /usr/local/bin
        sudo cp ugbc.d64 /usr/local/bin
        sudo cp ugbc.d32 /usr/local/bin

        cd $HOME

    echo "$fix" >>$file
    echo
fi


# update ugBasic
# check for fix
fix="fix-20230724-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/ugBasic-git-20230724-CoCoPi.tar.gz -C /

        cd $HOME/source/ugbasic/ugbc/exe
        sudo cp ugbc.coco /usr/local/bin
        sudo cp ugbc.d64 /usr/local/bin
        sudo cp ugbc.d32 /usr/local/bin

        cd $HOME

    echo "$fix" >>$file
    echo
fi


# update ugBasic
# check for fix
fix="fix-20230807-01"
if grep -q "$fix" $file; then
    echo fix $fix already complete.
    echo 
else
    echo Applying fix $fix...
    echo
    tar xzf /home/pi/update/ugBasic-git-20230807-CoCoPi.tar.gz -C /

        cd $HOME/source/ugbasic/ugbc/exe
        sudo cp ugbc.coco /usr/local/bin
        sudo cp ugbc.d64 /usr/local/bin
        sudo cp ugbc.d32 /usr/local/bin

        cd $HOME

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
