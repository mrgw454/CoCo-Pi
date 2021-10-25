#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>Main Menu</b>"
options=("TRS-80 Color Computer 2 Menu" \
         "TRS-80 Color Computer 2 Menu (XRoar)" \
         "Tandy  Color Computer 3 Menu"  \
         "Tandy  Color Computer 3 Menu (XRoar) WIP!"  \
         "Tandy  Color Computer 3 Menu (OVCC)"  \
         "TRS-80 MC-10 Menu" \
         "TRS-80 MC-10 Menu (XRoar) WIP!" \
         "Dragon Menu"  \
         "Dragon Menu (XRoar)" \
         "Attract Mode Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/scripts/CoCoPi-menu-Coco2-z2.sh & kill $$;;
    "${options[1]}" ) $HOME/scripts/CoCoPi-menu-Coco2-XRoar-z2.sh & kill $$;;
    "${options[2]}" ) $HOME/scripts/CoCoPi-menu-Coco3-z2.sh & kill $$;;
    "${options[3]}" ) $HOME/scripts/CoCoPi-menu-Coco3-XRoar-z2.sh & kill $$;;
    "${options[4]}" ) $HOME/scripts/CoCoPi-menu-Coco3-OVCC-z2.sh & kill $$;;
    "${options[5]}" ) $HOME/scripts/CoCoPi-menu-MC10-z2.sh & kill $$;;
    "${options[6]}" ) $HOME/scripts/CoCoPi-menu-MC10-XRoar-z2.sh & kill $$;;
    "${options[7]}" ) $HOME/scripts/CoCoPi-menu-Dragon-z2.sh & kill $$;;
    "${options[8]}" ) $HOME/scripts/CoCoPi-menu-Dragon-XRoar-z2.sh & kill $$;;
    "${options[9]}" ) $HOME/scripts/CoCoPi-menu-Attract-z2.sh & kill $$;;
     
     *) echo "Quitting...";;
    esac

done
