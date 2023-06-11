#!/bin/bash

cd $HOME/.xroar

XROARPARMSFILE=`cat $HOME/.xroar/.optional_xroar_parameters.txt`
export XROARPARMS=$XROARPARMSFILE

clear

xroar -c $HOME/.xroar/xroar.conf -default-machine coco2bus -load /media/share1/EMU/FLEX/fhl_flex_5_0_4.DMK -load /media/share1/EMU/FLEX/tsc_extended_basic.DMK -type 'RUN"FLEX"\r' $XROARPARMS

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
