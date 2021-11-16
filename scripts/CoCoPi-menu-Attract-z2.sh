#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>Attract Menu</b>"
options=("Coco 2 MAME     Attract Mode Carts (random)" \
         "Coco 3 MAME     Attract Mode Disks (random)" \
         "Coco 3 MAME     Attract Mode Carts (random)" \
         "Coco 2 MAME     Attract Mode Disks (SSFM)" \
         "Coco 2 XRoar    Attract Mode Carts (random)" \
         "Dragon 32 MAME  Attract Mode Carts (random)" \
         "Dragon 64 MAME  Attract Mode Disks (SSFM)" \
         "Dragon 32 XRoar Attract Mode Carts (random)" \
         "MC-10  MAME     Attract Mode Jim Gerrie (random)" \
         "Coco 3 MAME     Image Slideshow (random)" \
         "Coco 3 MAME     CoCoTracker Demo (random)" \
         "Coco Demo       Simultaneous Sessions" \
         "MAME            Play Donkey Kong Hacks" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/scripts/attract-mode-random-coco2.sh /media/share1/carts;;
    "${options[1]}" ) $HOME/scripts/attract-mode-random-coco3.sh /media/share1/SDC/DEMO;;
    "${options[2]}" ) $HOME/scripts/attract-mode-random-coco3.sh /media/share1/carts;;
    "${options[3]}" ) $HOME/scripts/attract-mode-coco2-ssfm.sh;;
    "${options[4]}" ) $HOME/scripts/attract-mode-random-coco2-xroar.sh /media/share1/carts;;
    "${options[5]}" ) $HOME/scripts/attract-mode-random-dragon.sh;;
    "${options[6]}" ) $HOME/scripts/attract-mode-dragon64h-ssfm.sh;;
    "${options[7]}" ) $HOME/scripts/attract-mode-dragon-random-xroar.sh;;
    "${options[8]}" ) $HOME/scripts/attract-mode-random-mc-10-128k.sh /media/share1/JIMG;;
    "${options[9]}" ) $HOME/scripts/attract-mode-random-coco3.sh /media/share1/RonD/BMP;;
    "${options[10}" ) $HOME/scripts/attract-mode-random-ORCH90.sh /media/share1/SDC/MUSIC/MODS;;
    "${options[11]}" ) $HOME/scripts/demo-mode.sh;;
    "${options[12]}" ) $HOME/scripts/attract-mode-dkong.sh;;
    "${options[13]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
