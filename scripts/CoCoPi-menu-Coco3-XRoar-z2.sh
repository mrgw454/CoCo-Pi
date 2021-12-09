#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>CoCo 3 XRoar Menu</b>"
options=("Tandy Color Computer 3 DECB" \
         "Tandy Color Computer 3 DECB w/6309" \
         "Tandy Color Computer 3 HDB-DOS" \
         "Tandy Color Computer 3 YA-DOS w/HDD" \
         "Tandy Color Computer 3 YA-DOS w/6309 & HDD" \
         "Tandy Color Computer 3 YA-DOS w/6809,512K & NitrOS9 EOU" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.xroar/coco3-decb-xroar.sh;;
    "${options[1]}" ) $HOME/.xroar/coco3h-decb-xroar.sh;;
    "${options[2]}" ) $HOME/.xroar/coco3-hdbdos-xroar.sh;;
    "${options[3]}" ) $HOME/.xroar/coco3-yados-HD-xroar.sh;;
    "${options[4]}" ) $HOME/.xroar/coco3h-yados-HD-xroar.sh;;
    "${options[5]}" ) $HOME/.xroar/coco3-yados-nitros9-xroar.sh;;
    "${options[6]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
