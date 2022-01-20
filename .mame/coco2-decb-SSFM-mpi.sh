clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

if [ -e $HOME/.mame/.override_ini_files ]
then

    echo Using existing ini file.
    echo

else

    # needed to ensure SSFM I/O address of &HFF56 is used for MPI
    cp $HOME/.mame/cfg/coco2h.cfg.SSFM-enabled $HOME/.mame/cfg/coco2h.cfg

fi

if [ -e $HOME/.mame/.mame_floppy ]
then
    floppy=`cat $HOME/.mame/.mame_floppy`

    if [ -e "$floppy" ]
    then

        echo "Floppy save file found - automounting [$floppy]"
        echo
        read -p  "Press any key to continue." -n1 -s
        echo

	mame coco2h -ram 64k -ext multi -ext:multi:slot1 ssfm -flop1 "$floppy" $MAMEPARMS

    else

	echo "Floppy disk image [$floppy] not found in floppy save file.  Aborting."
        echo
        echo "Please run \"Clear all saved mount files\" on Utilities Menu."
        echo
        read -p  "Press any key to continue." -n1 -s
        echo

    fi

else

mame coco2h -ram 64k -ext multi -ext:multi:slot1 ssfm -flop1 "$1" $MAMEPARMS

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
