#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>CoCo 2 Menu</b>"
options=("TRS-80 Color Computer 2 DECB" \
         "TRS-80 Color Computer 2 DECB    w/6309" \
         "TRS-80 Color Computer 2 DECB    w/SSC & MPI" \
         "TRS-80 Color Computer 2 DECB    w/GMC & MPI" \
         "TRS-80 Color Computer 2 ECB     w/GMC" \
         "TRS-80 Color Computer 2 DECB    w/6309,SSFM & MPI" \
         "TRS-80 Color Computer 2 HDB-DOS" \
         "TRS-80 Color Computer 2 HDB-DOS w/6309" \
         "TRS-80 Color Computer 2 HDB-DOS w/PLATO" \
         "TRS-80 Color Computer 2 YA-DOS  w/HDD" \
         "TRS-80 Color Computer 2 YA-DOS  w/6309 & HDD" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.mame/coco2-decb.sh;;
    "${options[1]}" ) $HOME/.mame/coco2-decb-6309.sh;;
    "${options[2]}" ) $HOME/.mame/coco2-decb-ssc-mpi.sh;;
    "${options[3]}" ) $HOME/.mame/coco2-decb-gmc-mpi.sh;;
    "${options[4]}" ) $HOME/.mame/coco2-ecb-gamemaster.sh;;
    "${options[5]}" ) $HOME/.mame/coco2-decb-SSFM-mpi.sh;;
    "${options[6]}" ) $HOME/.mame/coco2-hdbdos.sh;;
    "${options[7]}" ) $HOME/.mame/coco2-hdbdos-6309.sh;;
    "${options[8]}" ) $HOME/.mame/coco2-hdbdos-pyDW-PLATO.sh;;
    "${options[9]}" ) $HOME/.mame/coco2-yados-HD-mpi.sh;;
    "${options[10}" ) $HOME/.mame/coco2-yados-HD-6309-mpi.sh;;
    "${options[11]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
