#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>Clone Systems Menu</b>"
options=("Prológica CP400" \
         "Prológica CP400 Color II" \
         "Novo Tempo Color 64" \
         "ILCE SEP Micro-SEP 1600" \
         "Dynacom MX-1600" \
         "Terco AB 4426 CNC Programming Station" \
         "Tandy Videotex" \
         "Matra Alice" \
         "Matra Alice 32" \
         "Matra Alice 90" \
         "Matra Alice 128K (MCX-BASIC)" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.mame/cp400.sh;;
    "${options[1]}" ) $HOME/.mame/cp400c2.sh;;
    "${options[2]}" ) $HOME/.mame/lzcolor64.sh;;
    "${options[3]}" ) $HOME/.mame/ms1600.sh;;
    "${options[4]}" ) $HOME/.mame/mx1600.sh;;
    "${options[5]}" ) $HOME/.mame/t4426.sh;;
    "${options[6]}" ) $HOME/.mame/trsvidtx.sh;;
    "${options[7]}" ) $HOME/.mame/alice.sh;;
    "${options[8]}" ) $HOME/.mame/alice32.sh;;
    "${options[9]}" ) $HOME/.mame/alice90.sh;;
   "${options[10]}" ) $HOME/.mame/alice128.sh;;
   "${options[11]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
