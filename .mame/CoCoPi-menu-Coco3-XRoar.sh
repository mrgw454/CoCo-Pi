    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 75 10 \
    "1" "Tandy Color Computer 3 DECB" \
    "2" "Tandy Color Computer 3 DECB w/6309" \
    "3" "Tandy Color Computer 3 HDB-DOS" \
    "4" "Tandy Color Computer 3 YA-DOS w/HDD" \
    "5" "Tandy Color Computer 3 YA-DOS w/6309 & HDD" \
    "6" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) $HOME/.xroar/coco3-decb-xroar.sh;;
        2) $HOME/.xroar/coco3h-decb-xroar.sh;;
        3) $HOME/.xroar/coco3-hdbdos-xroar.sh;;
        4) $HOME/.xroar/coco3-yados-HD-xroar.sh;;
        5) $HOME/.xroar/coco3h-yados-HD-xroar.sh;;
        6) menu;;
        *) echo "Quitting...";;
    esac
