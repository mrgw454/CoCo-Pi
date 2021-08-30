    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 65 10 \
    "1" "Dragon 32" \
    "2" "Dragon 64" \
    "3" "Dragon 64 w/512k MOOH & NitrOS9 L2" \
    "4" "Dragon 200e" \
    "5" "Dragon Tano (NTSC)" \
    "6" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) $HOME/.xroar/dragon32-xroar.sh;;
        2) $HOME/.xroar/dragon64-xroar.sh;;
        3) $HOME/.xroar/dragon64-MOOH-xroar.sh;;
        4) $HOME/.xroar/dragon200e-xroar.sh;;
        5) $HOME/.xroar/dragontano-xroar.sh;;
        6) menu;;
        *) echo "Quitting...";;
    esac
