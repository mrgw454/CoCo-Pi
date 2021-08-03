clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

mame coco3h -ramsize 2048k -ext multi -flop1 /media/share1/EMU/EOU/63emu.vdk -hard1 /media/share1/EMU/EOU/63SDC.VHD -autoboot_delay 2 -autoboot_command 'DOS\n' $MAMEPARMS

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
