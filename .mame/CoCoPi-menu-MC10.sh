    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 65 10 \
    "1" "TRS-80 Micro Color Computer   4K" \
    "2" "TRS-80 Micro Color Computer  16K (external RAM)" \
    "3" "TRS-80 Micro Color Computer  20K (internal RAM)" \
    "4" "TRS-80 Micro Color Computer  32K (internal RAM)" \
    "5" "TRS-80 Micro Color Computer 128K (MCX BASIC) & pyDW" \
    "6" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) mc-10-4k.sh;;
        2) mc-10-16k.sh;;
        3) mc-10-20k.sh;;
        4) mc-10-32k.sh;;
        5) mc-10-MCX128-pyDW.sh;;
        6) menu;;
        *) echo "Quitting...";;
    esac
