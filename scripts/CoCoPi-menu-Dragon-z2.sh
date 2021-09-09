#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>Dragon Menu</b>"
options=("Dragon 32" \
         "Dragon 64" \
         "Dragon 64 Plus" \
         "Dragon 128 (Beta)" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.mame/dragon32.sh;;
    "${options[1]}" ) $HOME/.mame/dragon64.sh;;
    "${options[2]}" ) $HOME/.mame/dragon64plus.sh;;
    "${options[3]}" ) $HOME/.mame/dragon128.sh;;
    "${options[4]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
