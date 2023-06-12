clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

if [ -e $HOME/.mame/.override_ini_files ]
then

    echo Using existing ini file.
    echo

else

    # disable Becker port
    cp $HOME/.mame/cfg/coco2b.cfg.beckerport-disabled $HOME/.mame/cfg/coco2b.cfg

fi

    mame coco2b -ramsize 64k -flop1 /media/share1/EMU/FLEX/fhl_flex_5_0_4.DMK -flop2 /media/share1/EMU/FLEX/tsc_extended_basic.DMK -autoboot_delay 2 -autoboot_command '\nRUN"FLEX"\n' $MAMEPARMS

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
