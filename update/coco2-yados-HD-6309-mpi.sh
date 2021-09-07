clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw server hdbdos false

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 0 /media/share1/DW4/AUTOEXEC/AUTOEXEC.DSK
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 1 /media/share1/DW4/YADOS/yados.dsk

if [ -e $HOME/.mame/.override_ini_files ]
then

    echo Using existing ini file.
    echo

else

    # enable Becker port
    cp $HOME/.mame/cfg/coco2h.cfg.beckerport-enabled $HOME/.mame/cfg/coco2h.cfg

fi

mame coco2h -ramsize 64k -ext multi -ext:multi:slot4 fdcv11 -cart5 /media/share1/roms/yados.rom -hard1 /media/share1/EMU/VHD/HDD.DSK -autoboot_delay 8 -autoboot_command 'N\nDRIVE I 1,6,3\nDRIVE U 0\nDRIVE M 0,1,0,0,0\nDRIVE M 1,0,0\nDRIVE M 2,0,1\nDRIVE I:DRIVE M\n\nRUN"WIDTH32.BAS:1"\n' $MAMEPARMSFILE

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 1

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw server hdbdos true

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
