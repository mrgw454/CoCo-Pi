    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1"  "System Status" \
    "2" "Edit      RVPN config" \
    "3" "Start     RVPN network daemon" \
    "4" "Stop      RVPN network daemon" \
    "5" "View      RVPN network log" \
    "6" "Show      RVPN network status" \
    "7" "Reboot    Raspberry Pi" \
    "8" "Shutdown  Raspberry Pi" \
    "9" "Return to Utilities Menu" \
    "10" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) status.sh && CoCoPi-menu-Utilities-RVPN.sh;;
        2) editRVPN.sh && CoCoPi-menu-Utilities-RVPN.sh;;
        3) $HOME/rvpn/startRVPN.sh && CoCoPi-menu-Utilities-RVPN.sh;;
        4) $HOME/rvpn/stopRVPN.sh && CoCoPi-menu-Utilities-RVPN.sh;;
        5) viewRVPN-log.sh && CoCoPi-menu-Utilities-RVPN.sh;;
        6) statusRVPN.sh && CoCoPi-menu-Utilities-RVPN.sh;;
        7) rebootRPi.sh;;
        8) shutdownRPi.sh;;
        9) CoCoPi-menu-Utilities.sh;;
        10) menu;;
        *) echo "Quitting...";;
    esac
