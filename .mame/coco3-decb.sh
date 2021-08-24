clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# disable Becker port
cp $HOME/.mame/cfg/coco3.cfg.beckerport-disabled $HOME/.mame/cfg/coco3.cfg

if [ -e $HOME/.mame/.mame_floppy ]
then
    floppy=`cat $HOME/.mame/.mame_floppy`

    if [ -e "$floppy" ]
    then

    	echo "Floppy save file found - automounting [$floppy]"
    	echo
    	read -p  "Press any key to continue." -n1 -s
    	echo

    	mame coco3 -ramsize 512k -ext multi -flop1 "$floppy" $MAMEPARMS > /dev/null

    else

    	echo "Floppy disk image [$floppy] not found in floppy save file.  Aborting."
	echo
	echo "Please run \"Clear all saved mount files\" on Utilities Menu."
    	echo
    	read -p  "Press any key to continue." -n1 -s
    	echo

    fi

else

    mame coco3 -ramsize 512k -ext multi $MAMEPARMS > /dev/null

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
CoCoPi-menu-Coco3.sh
