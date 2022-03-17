clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

if [ -e $HOME/.mame/.override_ini_files ]
then

    echo Using existing ini file.
    echo

else

    # enable Becker port
    cp $HOME/.mame/cfg/coco3h.cfg.beckerport-enabled $HOME/.mame/cfg/coco3h.cfg

fi


#$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw server hdbdos false

#$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
#$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 0 $HOME/source/eou_ide/build/6309_ide/63IDE.dsk

mame coco3h -ramsize 2048k -ext ide -ext:ide:slot fdcv11 -flop1 /$HOME/source/eou_ide/build/6309_ide/63IDE.dsk -hard3 $HOME/source/eou_ide/build/6309_ide/63IDE.VHD -ext:ide:ata:1 hdd -hard4 /media/share1/EMU/EOU/EOU_USER.VHD -autoboot_delay 2 -autoboot_command 'DOS\n' $MAMEPARMS

#$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
#$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw server hdbdos true


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
