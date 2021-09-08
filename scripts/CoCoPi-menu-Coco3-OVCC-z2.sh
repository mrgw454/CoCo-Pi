#!/bin/bash

title="$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)"
prompt="<b>CoCo 3 OVCC Menu</b>"
options=("Tandy Color Computer 3 DECB" \
         "Tandy Color Computer 3 DECB    w/6309,2MB" \
         "Tandy Color Computer 3 DECB    w/6309 & ORCH90" \
         "Tandy Color Computer 3 HDB-DOS" \
         "Tandy Color Computer 3 HDB-DOS w/6309,2MB & NitrOS9 EOU" \
         "Tandy Color Computer 2 HDB-DOS w/6309,2MB,Fuzix & pyDW" \
         "Tandy Color Computer 2 HDB-DOS w/6309,2MB,Fuzix & lwwire" \
         "Tandy Color Computer 2 HDB-DOS w/PLATO" \
         "Tandy Color Computer 3 YA-DOS  w/6309,2MB & HDD" \
         "Return to Main Menu")

while opt=$(zenity --width=640 --height=480 --title="$title" --text="$prompt" --list  --column=""  "${options[@]}"); do
    select=""

    case "$opt" in
    "${options[0]}" ) $HOME/.ovcc/coco3-decb-OVCC.sh;;
    "${options[1]}" ) $HOME/.ovcc/coco3-decb-6309-2MB-OVCC.sh;;
    "${options[2]}" ) $HOME/.ovcc/coco3-decb-6309-ORCH90-OVCC.sh;;
    "${options[3]}" ) $HOME/.ovcc/coco3-hdbdos-OVCC.sh;;
    "${options[4]}" ) $HOME/.ovcc/coco3-hdbdos-6309-nitros9-OVCC.sh;;
    "${options[5]}" ) $HOME/.ovcc/coco3-Fuzix-pyDW-OVCC.sh;;
    "${options[6]}" ) $HOME/.ovcc/coco3-Fuzix-lwwire-OVCC.sh;;
    "${options[7]}" ) $HOME/.ovcc/coco3-hdbdos-pyDW-PLATO-OVCC.sh;;
    "${options[8]}" ) $HOME/.ovcc/coco3-yados-HD-6309-mpi-OVCC.sh;;
    "${options[9]}" ) $HOME/scripts/menu-z2.sh & kill $$;;

     *) echo "Quitting...";;
    esac

done
