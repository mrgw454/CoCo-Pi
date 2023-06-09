    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 65 10 \
    "1" "TRS-80 Color Computer 2 DECB" \
    "2" "TRS-80 Color Computer 2 w/6309 DECB" \
    "3" "TRS-80 Color Computer 2 HDB-DOS" \
    "4" "TRS-80 Color Computer 2 YA-DOS w/HDD" \
    "5" "TRS-80 Color Computer 2 YA-DOS w/6309 & HDD" \
    "6" "TRS-80 Color Computer 2 w/512K MOOH" \
    "7" "TRS-80 Color Computer 2 w/GMC & CASSETTE image" \
    "8" "TRS-80 Color Computer 2 w/GMC & BIN image" \
    "9" "TRS-80 Color Computer 2 w/GMC & ROM image" \
    "10" "TRS-80 Color Computer 2 w/GMC & DSK image" \
    "11" "TRS-80 Color Computer 2 HDB-DOS w/PLATO" \
    "12" "TRS-80 Color Computer 2 w/FLEX" \
    "13" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) $HOME/.xroar/coco2b-decb-xroar.sh;;
        2) $HOME/.xroar/coco2bh-decb-xroar.sh;;
        3) $HOME/.xroar/coco2b-hdbdos-xroar.sh;;
        4) $HOME/.xroar/coco2us-yados-HD-xroar.sh;;
        5) $HOME/.xroar/coco2hus-yados-HD-xroar.sh;;
        6) $HOME/.xroar/coco2us-MOOH-xroar-Becker.sh;;
        7) $HOME/.xroar/coco2b-GMC-CAS-xroar.sh;;
        8) $HOME/.xroar/coco2b-GMC-BIN-xroar.sh;;
        9) $HOME/.xroar/coco2b-GMC-ROM-xroar.sh;;
       10) $HOME/.xroar/coco2b-GMC-FLOPPY-xroar.sh;;
       11) $HOME/.xroar/coco2b-hdbdos-pyDW-PLATO-xroar.sh;;
       12) $HOME/.xroar/coco2b-flex-xroar.sh;;
       13) menu;;
        *) echo "Quitting...";;
    esac
