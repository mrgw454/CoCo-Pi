    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 65 10 \
    "1" "TRS-80 Micro Color Computer   4K" \
    "2" "TRS-80 Micro Color Computer  20K" \
    "3" "TRS-80 Micro Color Computer  32K" \
    "4" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) mc-10-4k-xroar.sh;;
        2) mc-10-20k-xroar.sh;;
        3) mc-10-32k-xroar.sh;;
        4) menu;;
        *) echo "Quitting...";;
    esac
