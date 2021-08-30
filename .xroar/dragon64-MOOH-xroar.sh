#!/bin/bash

cd $HOME/.xroar

XROARPARMSFILE=`cat $HOME/.xroar/.optional_xroar_parameters.txt`
export XROARPARMS=$XROARPARMSFILE

clear

    # link to proper sdcard.img
    rm sdcard.img
    ln -s sdcard-dualboot-co42.img sdcard.img

#    xroar -default-machine cocous -cart mooh -cart-rom sdbdos-eprom8-all-v1.rom -ao-fragments 1
    xroar -default-machine dragon64 -cart mooh -cart-rom sdbdos-eprom8-all-v1.rom $XROARPARMS

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
CoCoPi-menu-Dragon-XRoar.sh
