clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

cp $HOME/.mame/cfg/coco2.cfg.artifacting-disabled $HOME/.mame/cfg/coco2.cfg

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 0 /media/share1/DW4/GORDON/PLATO/plato.dsk

mame coco2 -ramsize 64k -cart /media/share1/roms/hdbdw3bck.rom $MAMEPARMS

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

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0

cp $HOME/.mame/cfg/coco2.cfg.artifacting-enabled $HOME/.mame/cfg/coco2.cfg

cd $HOME/.mame
CoCoPi-menu-Coco2.sh

