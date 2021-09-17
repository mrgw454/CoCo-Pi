#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>CoCo 3 Menu</b>"
options=("Tandy Color Computer 3 DECB" \
         "Tandy Color Computer 3 DECB    w/6309,2MB" \
         "Tandy Color Computer 3 DECB    w/SSC & MPI" \
         "Tandy Color Computer 3 DECB    w/GMC & MPI" \
         "Tandy Color Computer 3 ECB     w/GMC" \
         "Tandy Color Computer 3 DECB    w/6309 & ORCH90" \
         "Tandy Color Computer 3 DECB    w/Deluxe RS-232 Pak" \
         "Tandy Color Computer 3 HDB-DOS" \
         "Tandy Color Computer 3 HDB-DOS w/6309,2MB & NitrOS9 EOU" \
         "Tandy Color Computer 2 HDB-DOS w/6309,2MB,Fuzix & pyDW" \
         "Tandy Color Computer 2 HDB-DOS w/6309,2MB,Fuzix & lwwire" \
         "Tandy Color Computer 2 HDB-DOS w/PLATO" \
         "Tandy Color Computer 3 YA-DOS  w/HDD" \
         "Tandy Color Computer 3 YA-DOS  w/6309,2MB & HDD" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --window-icon="/home/pi/Pictures/CoCo-Pi.png" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.mame/coco3-decb.sh;;
    "${options[1]}" ) $HOME/.mame/coco3-decb-6309-2MB.sh;;
    "${options[2]}" ) $HOME/.mame/coco3-decb-ssc-mpi.sh;;
    "${options[3]}" ) $HOME/.mame/coco3-decb-gmc-mpi.sh;;
    "${options[4]}" ) $HOME/.mame/coco3-ecb-gamemaster.sh;;
    "${options[5]}" ) $HOME/.mame/coco3-decb-6309-ORCH90.sh;;
    "${options[6]}" ) $HOME/.mame/coco3-decb-term.sh;;
    "${options[7]}" ) $HOME/.mame/coco3-hdbdos.sh;;
    "${options[8]}" ) $HOME/.mame/coco3-hdbdos-6309-nitros9.sh;;
    "${options[9]}" ) $HOME/.mame/coco3-Fuzix-pyDW.sh;;
    "${options[10]}" ) $HOME/.mame/coco3-Fuzix-lwwire.sh;;
    "${options[11]}" ) $HOME/.mame/coco3-hdbdos-pyDW-PLATO.sh;;
    "${options[12]}" ) $HOME/.mame/coco3-yados-HD-mpi.sh;;
    "${options[13]}" ) $HOME/.mame/coco3-yados-HD-6309-mpi.sh;;
    "${options[14]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
