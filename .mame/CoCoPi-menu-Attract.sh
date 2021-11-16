    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1" "Coco 2 MAME     Attract Mode Carts (random)" \
    "2" "Coco 3 MAME     Attract Mode Disks (random)" \
    "3" "Coco 3 MAME     Attract Mode Carts (random)" \
    "4" "Dragon 64 MAME  Attract Mode Disks (SSFM)" \
    "5" "Coco 2 XRoar    Attract Mode Carts (random)" \
    "6" "Dragon 32 MAME  Attract Mode Carts (random)" \
    "7" "Dragon 64 MAME  Attract Mode Disks (SSFM)" \
    "8" "Dragon 32 XRoar Attract Mode Carts (random)" \
    "9" "MC-10 MAME      Attract Mode Jim Gerrie (random)" \
    "10 "Coco 3 MAME     Image Slideshow (random)" \
    "11" "Coco 3 MAME     CoCoTracker Demo (random)" \
    "12" "Coco Demo       Simultaneous Sessions" \
    "13" "MAME            Play Donkey Kong Hacks" \
    "14" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) attract-mode-random-coco2.sh /media/share1/carts && CoCoPi-menu-Attract.sh;;
        2) attract-mode-random-coco3.sh /media/share1/SDC/DEMO && CoCoPi-menu-Attract.sh;;
        3) attract-mode-random-coco3.sh /media/share1/carts && CoCoPi-menu-Attract.sh;;
        4) attract-mode-coco2-ssfm.sh && CoCoPi-menu-Attract.sh;;
        5) attract-mode-random-coco2-xroar.sh /media/share1/carts && CoCoPi-menu-Attract.sh;;
        6) attract-mode-random-dragon.sh && CoCoPi-menu-Attract.sh;;
        7) attract-mode-dragon64h-ssfm.sh && CoCoPi-menu-Attract.sh;;
        8) attract-mode-dragon-random-xroar.sh && CoCoPi-menu-Attract.sh;;
        9) attract-mode-random-mc-10-128k.sh /media/share1/JIMG && CoCoPi-menu-Attract.sh;;
       10) attract-mode-random-coco3.sh /media/share1/RonD/BMP && CoCoPi-menu-Attract.sh;;
       11) attract-mode-random-ORCH90.sh /media/share1/SDC/MUSIC/MODS && CoCoPi-menu-Attract.sh;;
       12) demo-mode.sh && CoCoPi-menu-Attract.sh;;
       13) attract-mode-dkong.sh && CoCoPi-menu-Attract.sh;;
       14) menu;;
        *) echo "Quitting...";;
    esac

