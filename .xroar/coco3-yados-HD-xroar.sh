clear

cd $HOME/.xroar

XROARPARMSFILE=`cat $HOME/.xroar/.optional_xroar_parameters.txt`
export XROARPARMS=$XROARPARMSFILE

clear

cd $HOME/.xroar

# link to proper sdcard.img
    rm hd0.img
    ln -s /media/share1/EMU/VHD/hd0-XRoar-256MB.img hd0.img

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw server hdbdos false

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 0 /media/share1/DW4/AUTOEXEC/AUTOEXEC.DSK
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 1 /media/share1/DW4/YADOS/yados.dsk

xroar -c $HOME/.xroar/xroar.conf -default-machine coco3 -machine-cart ide -type 'N\rDRIVE I 1,4,3\rDRIVE U 0\rDRIVE M 0,1,0,0,0\rDRIVE M 1,0,0\rDRIVE M 2,0,1\rDRIVE I:DRIVE M\rLOAD"WIDTH32.BAS:1"\rRUN\r' $XROARPARMS

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 1

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw server hdbdos true

# capture XRoar ERRORLEVEL

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
CoCoPi-menu-Coco3-XRoar.sh
exit











