clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# disable Becker port
cp $HOME/.mame/cfg/coco3h.cfg.beckerport-disabled $HOME/.mame/cfg/coco3h.cfg

#mame coco3h -ramsize 512k -ext multi -ext:multi:slot4 fdcv11 -ext:multi:slot1 orch90 -flop1 /media/share1/SDC/MUSIC/MOD6309.DSK -flop2 /media/share1/SDC/MUSIC/MODS/EVERYBREA.DSK -flop3 /media/share1/SDC/MUSIC/MODS/ABBA.DSK -flop4 /media/share1/SDC/MUSIC/MODS/007THEME.DSK -autoboot_delay 2 -autoboot_command 'RUN"MOD13.BAS"\n' $MAMEPARMSFILE
mame coco3h -ramsize 512k -ext multi -ext:multi:slot4 fdcv11 -ext:multi:slot1 orch90 -flop1 /media/share1/SDC/MUSIC/MOD6309.DSK -flop2 /media/share1/SDC/MUSIC/MODS/EVERYBREA.DSK -autoboot_delay 2 -autoboot_command 'RUN"MOD13.BAS"\n' $MAMEPARMSFILE

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
