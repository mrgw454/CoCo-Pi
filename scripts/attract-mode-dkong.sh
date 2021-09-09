#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# Play one of Sockmaster's Donkey Kong Hacks

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

     clear
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo "Press [ESC] to EXIT game."
     sleep 2
     mame dkongx11 $MAMEPARMS

cd $HOME/.mame
