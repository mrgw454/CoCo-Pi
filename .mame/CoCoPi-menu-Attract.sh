    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1" "Coco 2 MAME     Attract Mode Carts (random)" \
    "2" "Coco 3 MAME     Attract Mode Disks (random)" \
    "3" "Coco 3 MAME     Attract Mode Carts (random)" \
    "4" "Coco 2 XRoar    Attract Mode Carts (random)" \
    "5" "Dragon 32 MAME  Attract Mode Carts (random)" \
    "6" "Dragon 32 XRoar Attract Mode Carts (random)" \
    "7" "Coco 3 MAME     Image Slideshow (random)" \
    "8" "Coco 3 MAME     CoCoTracker Demo (random)" \
    "9" "MAME            Play Donkey Kong Hacks" \
    "10" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) attract-mode-random-coco2.sh /media/share1/carts && CoCoPi-menu-Attract.sh;;
        2) attract-mode-random-coco3.sh /media/share1/SDC/DEMO && CoCoPi-menu-Attract.sh;;
        3) attract-mode-random-coco3.sh /media/share1/carts && CoCoPi-menu-Attract.sh;;
        4) attract-mode-random-coco2-xroar.sh /media/share1/carts && CoCoPi-menu-Attract.sh;;
        5) attract-mode-random-dragon.sh && CoCoPi-menu-Attract.sh;;
        6) attract-mode-random-dragon-xroar.sh && CoCoPi-menu-Attract.sh;;
        7) attract-mode-random-coco3.sh /media/share1/RonD/BMP && CoCoPi-menu-Attract.sh;;
        8) attract-mode-random-ORCH90.sh /media/share1/SDC/MUSIC/MODS && CoCoPi-menu-Attract.sh;;
        9) attract-mode-dkong.sh && CoCoPi-menu-Attract.sh;;
       10) menu;;
        *) echo "Quitting...";;
    esac

