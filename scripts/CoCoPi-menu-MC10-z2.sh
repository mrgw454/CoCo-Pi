#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>MC-10 Menu</b>"
options=("TRS-80 Micro Color Computer   4K" \
         "TRS-80 Micro Color Computer  16K (external RAM)" \
         "TRS-80 Micro Color Computer  20K (internal RAM)" \
         "TRS-80 Micro Color Computer  32K (internal RAM)" \
         "TRS-80 Micro Color Computer 128K (MCX BASIC) & pyDW" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.mame/mc-10-4k.sh;;
    "${options[1]}" ) $HOME/.mame/mc-10-16k.sh;;
    "${options[2]}" ) $HOME/.mame/mc-10-20k.sh;;
    "${options[3]}" ) $HOME/.mame/mc-10-32k.sh;;
    "${options[4]}" ) $HOME/.mame/mc-10-MCX128-pyDW.sh;;
    "${options[5]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
