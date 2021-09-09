#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>Dragon XRoar Menu</b>"
options=("Dragon 32" \
         "Dragon 64" \
         "Dragon 64 w/512k MOOH & NitrOS9 L2" \
         "Dragon 200e" \
         "Dragon Tano (NTSC)" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.xroar/dragon32-xroar.sh;;
    "${options[1]}" ) $HOME/.xroar/dragon64-xroar.sh;;
    "${options[2]}" ) $HOME/.xroar/dragon64-MOOH-xroar.sh;;
    "${options[3]}" ) $HOME/.xroar/dragon200e-xroar.sh;;
    "${options[3]}" ) $HOME/.xroar/dragontano-xroar.sh;;
    "${options[4]}" ) $HOME/scripts/menu-z2.sh & kill $$;;
     
     *) echo "Quitting...";;
    esac

done
