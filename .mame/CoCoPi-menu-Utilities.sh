#!/bin/bash

export NEWT_COLORS='
root=black,black
border=black,black
window=black,black
shadow=black,black
title=brightgreen,black
button=white,black
actbutton=black,white
checkbox=back,black
actcheckbox=black,black
entry=green,black
label=white,black
listbox=green,black
actlistbox=black,green
textbox=white,black
acttextbox=black,white
helpline=black
roottext=black
disentry=black,black
compactbutton=black,black
actsellistbox=black,green
sellistbox=green,black
'

    clear

    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1" "System Status" \
    "2" "CoCoPi    Administration Menu" \
    "3" "CoCoPi    Downloads Menu" \
    "4" "CoCoPi    Drive Emulation Menu" \
    "5" "CoCoPi    Mount Media Menu" \
    "6" "CoCoPi    RVPN Menu" \
    "7" "Reboot    Raspberry Pi" \
    "8" "Shutdown  Raspberry Pi" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) status.sh && CoCoPi-menu-Utilities.sh;;
        2) CoCoPi-menu-Utilities-Administration.sh;;
        3) CoCoPi-menu-Utilities-Downloads.sh;;
        4) CoCoPi-menu-Utilities-DriveEmu.sh;;
        5) CoCoPi-menu-Utilities-MountMedia.sh;;
        6) CoCoPi-menu-Utilities-RVPN.sh;;
        7) rebootRPi.sh;;
        8) shutdownRPi.sh;;
        *) echo "Quitting...";;
    esac
