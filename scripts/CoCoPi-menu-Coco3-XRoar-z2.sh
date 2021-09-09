#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>CoCo 3 XRoar Menu</b>"
options=("Tandy Color Computer 3 DECB" \
         "Tandy Color Computer 3 HDB-DOS" \
         "Tandy Color Computer 3 YA-DOS  w/HDD" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.xroar/coco3-decb-xroar.sh;;
    "${options[1]}" ) $HOME/.xroar/coco3-hdbdos-xroar.sh;;
    "${options[2]}" ) $HOME/.xroar/coco3-yados-HD-xroar.sh;;
    "${options[3]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
