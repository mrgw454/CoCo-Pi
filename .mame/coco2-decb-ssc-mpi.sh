clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# disable Becker port
cp $HOME/.mame/cfg/coco2.cfg.beckerport-disabled $HOME/.mame/cfg/coco2.cfg

mame coco2 -ramsize 64k -ext multi -ext:multi:slot3 ssc -flop1 "/media/share1/SDC/LINDNER/SSCPRG.DSK" -autoboot_delay 2 -autoboot_command 'RUN "BLOOD.BAS"\n' $MAMEPARMS

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
