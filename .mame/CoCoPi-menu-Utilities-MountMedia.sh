    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1"  "System Status" \
    "2" "Mount     DSK image in Drivewire" \
    "3" "Mount     DSK image in pyDriveWire" \
    "4" "Mount     DSK image in MAME" \
    "5" "Mount     DSK image in XRoar" \
    "6" "Mount     CASSETTE image in XRoar" \
    "7" "Mount     BIN image in XRoar" \
    "8" "Mount     ROM image in MAME" \
    "9" "Mount     ROM image in XRoar" \
    "10" "Show      all saved mount files" \
    "11" "Clear     all saved mount files" \
    "12" "Select    default YA-DOS HDD image" \
    "13" "Edit      pyDriveWire configuration" \
    "14" "Cassette  Turbo loader for HDBDOS (CoCo)" \
    "15" "Cassette  WAV file loader (MC-10)" \
    "16" "Reboot    Raspberry Pi" \
    "17" "Shutdown  Raspberry Pi" \
    "18" "Return to Utilities Menu" \
    "19" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) status.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        2) mountDWfile.sh 0 0 && CoCoPi-menu-Utilities-MountMedia.sh;;
        3) mountpyDWfile.sh 0 0 && CoCoPi-menu-Utilities-MountMedia.sh;;
        4) mountFloppy.sh /media/share1/ && CoCoPi-menu-Utilities-MountMedia.sh;;
        5) mountXRoarFloppy.sh /media/share1/ && CoCoPi-menu-Utilities-MountMedia.sh;;
        6) mountXRoarCassette.sh /media/share1/cassette/ && CoCoPi-menu-Utilities-MountMedia.sh;;
        7) mountXRoarBin.sh /media/share1/ && CoCoPi-menu-Utilities-MountMedia.sh;;
        8) mountROM.sh /media/share1/ && CoCoPi-menu-Utilities-MountMedia.sh;;
	9) mountXRoarROM.sh /media/share1/roms/ && CoCoPi-menu-Utilities-MountMedia.sh;;
        10) mountShow.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        11) mountClear.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        12) select-hdd.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        13) editpyDWconfig.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        14) cloadm-hdbdos.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        15) cloadm-mc10.sh && CoCoPi-menu-Utilities-MountMedia.sh;;
        16) rebootRPi.sh;;
        17) shutdownRPi.sh;;
        18) CoCoPi-menu-Utilities.sh;;
        19) menu;;
        *) echo "Quitting...";;
    esac
