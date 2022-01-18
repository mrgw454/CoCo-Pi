#!/bin/bash

cd $HOME/.xroar

XROARPARMSFILE=`cat $HOME/.xroar/.optional_xroar_parameters.txt`
export XROARPARMS=$XROARPARMSFILE

clear

    # link to proper SD card image
    rm sdcard.img
    ln -s sdcard-dualboot-co42-DW-ronklein.img sdcard.img


# SD card image way
#  xroar -default-machine cocous -nodos -cart mooh -cart-becker -cart-rom sdbdos-eprom8-all-v1.rom

# DW disk image way
#  xroar -default-machine coco2us -cart mooh -cart-rom ~/source/sdboot/bootrom/eprom8.rom -cart-becker -load-sd ./sdcard.img $XROARPARMS
   xroar -default-machine coco2us -cart mooh -cart-rom ~/source/sdboot/bootrom/eprom8.rom -cart-becker -cart mpi -mpi-load-cart 0=mooh -mpi-load-cart 3=rsdos -mpi-slot 0 -load-sd ./sdcard.img $XROARPARMS

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
CoCoPi-menu-Coco2-XRoar.sh
