    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1" "TRS-80 Color Computer 2 DECB" \
    "2" "TRS-80 Color Computer 2 DECB w/6309" \
    "3" "TRS-80 Color Computer 2 DECB w/SSC & MPI" \
    "4" "TRS-80 Color Computer 2 DECB w/GMC & MPI" \
    "5" "TRS-80 Color Computer 2 ECB  w/GMC" \
    "6" "TRS-80 Color Computer 2 DECB w/6309,SSFM & MPI" \
    "7" "TRS-80 Color Computer 2 HDB-DOS" \
    "8" "TRS-80 Color Computer 2 HDB-DOS w/6309" \
    "9" "TRS-80 Color Computer 2 HDB-DOS w/PLATO" \
    "10" "TRS-80 Color Computer 2 YA-DOS w/HDD" \
    "11" "TRS-80 Color Computer 2 YA-DOS w/6309 & HDD" \
    "12" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) coco2-decb.sh;;
        2) coco2-decb-6309.sh;;
        3) coco2-decb-ssc-mpi.sh;;
        4) coco2-decb-gmc-mpi.sh;;
        5) coco2-ecb-gamemaster.sh;;
	6) coco2-decb-SSFM-mpi.sh;;
        7) coco2-hdbdos.sh;;
        8) coco2-hdbdos-6309.sh;;
        9) coco2-hdbdos-pyDW-PLATO.sh;;
       10) coco2-yados-HD-mpi.sh;;
       11) coco2-yados-HD-6309-mpi.sh;;
       12) menu;;
        *) echo "Quitting...";;
    esac
