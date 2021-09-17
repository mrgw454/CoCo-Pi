    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1"  "System Status" \
    "2"  "Start     pyDriveWire server" \
    "3"  "Stop      pyDriveWire server" \
    "4"  "Edit      pyDriveWire configuration" \
    "5"  "Select    pyDriveWire version" \
    "6"  "Restart   Drivewire 4" \
    "7"  "Stop      Drivewire 4" \
    "8"  "Start     lwwire (Use option 9 prior to running)" \
    "9"  "Stop      lwwire" \
    "10" "Edit      lwwire configuration" \
    "11" "Start     emceed file server (MC-10)" \
    "12" "Stop      emceed file server (MC-10)" \
    "13" "Reboot    Raspberry Pi" \
    "14" "Shutdown  Raspberry Pi" \
    "15" "Return to Utilities Menu" \
    "16" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) status.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        2) $HOME/pyDriveWire/start_pyDW.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        3) $HOME/pyDriveWire/stop_pyDW.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        4) nano $HOME/.pydrivewirerc && CoCoPi-menu-Utilities-DriveEmu.sh;;
        5) select-pyDW.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        6) $HOME/DriveWire4/restartDW4.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        7) $HOME/DriveWire4/stopDW4.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        8) $HOME/lwwire/startlwwire.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        9) $HOME/lwwire/stoplwwire.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        10) $HOME/lwwire/edit-tcpserv.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        11) $HOME/emceed/start_emceed.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        12) $HOME/emceed/stop_emceed.sh && CoCoPi-menu-Utilities-DriveEmu.sh;;
        13) rebootRPi.sh;;
        14) shutdownRPi.sh;;
        15) CoCoPi-menu-Utilities.sh;;
        16) menu;;
        *) echo "Quitting...";;
    esac
