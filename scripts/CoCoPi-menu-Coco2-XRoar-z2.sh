#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>CoCo 2 XRoar Menu</b>"
options=("TRS-80 Color Computer 2 DECB" \
         "TRS-80 Color Computer 2 w/6309 DECB" \
         "TRS-80 Color Computer 2 HDB-DOS" \
         "TRS-80 Color Computer 2 YA-DOS w/HDD" \
         "TRS-80 Color Computer 2 YA-DOS w/6309 & HDD" \
         "TRS-80 Color Computer 2 w/512K MOOH" \
         "TRS-80 Color Computer 2 w/GMC & CASSETTE image" 
         "TRS-80 Color Computer 2 w/GMC & BIN image" \
         "TRS-80 Color Computer 2 w/GMC & ROM image" \
         "TRS-80 Color Computer 2 w/GMC & DSK image" \
         "TRS-80 Color Computer 2 HDB-DOS w/PLATO" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.xroar/coco2b-decb-xroar.sh;;
    "${options[1]}" ) $HOME/.xroar/coco2bh-decb-xroar.sh;;
    "${options[2]}" ) $HOME/.xroar/coco2b-hdbdos-xroar.sh;;
    "${options[3]}" ) $HOME/.xroar/coco2us-yados-HD-xroar.sh;;
    "${options[4]}" ) $HOME/.xroar/coco2hus-yados-HD-xroar.sh;;
    "${options[5]}" ) $HOME/.xroar/coco2us-MOOH-xroar-Becker.sh;;
    "${options[6]}" ) $HOME/.xroar/coco2b-GMC-CAS-xroar.sh;;
    "${options[7]}" ) $HOME/.xroar/coco2b-GMC-BIN-xroar.sh;;
    "${options[8]}" ) $HOME/.xroar/coco2b-GMC-ROM-xroar.sh;;
    "${options[9]}" ) $HOME/.xroar/coco2b-GMC-FLOPPY-xroar.sh;;
    "${options[10]}" ) $HOME/.xroar/coco2b-hdbdos-pyDW-PLATO-xroar.sh;;
    "${options[11]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
