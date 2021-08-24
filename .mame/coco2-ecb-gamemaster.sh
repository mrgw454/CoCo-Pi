clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# disable Becker port
cp $HOME/.mame/cfg/coco2.cfg.beckerport-disabled $HOME/.mame/cfg/coco2.cfg

if [ -e $HOME/.mame/.mame_rom ]
then
    rom=`cat $HOME/.mame/.mame_rom`

    if [ -e "$rom" ]
    then

        echo "ROM save file found - automounting [$rom]"
        echo
        read -p  "Press any key to continue." -n1 -s
        echo

	mame coco2 -ext gmc -cart "$rom" $MAMEPARMS

    else

        echo "ROM image [$rom] not found in ROM save file.  Aborting."
        echo
        echo "Please run \"Clear all saved mount files\" on Utilities Menu."
        echo
        read -p  "Press any key to continue." -n1 -s
        echo

    fi

else

	mame coco2 -ext gmc -cart /media/share1/roms/cocofest.rom $MAMEPARMS

fi

# capture MAME ERRORLEVEL

if [ $? -eq 0 ]
then
	echo
else
	echo
	echo "Please make note of message above when requesting help."
	echo
	read -p  "Press any key to continue." -n1 -s
fi

cd $HOME/.mame
CoCoPi-menu-Coco2.sh
