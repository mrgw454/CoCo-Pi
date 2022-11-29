    clear
    RETVAL=$(whiptail --title "$(cat $HOME/cocopi-release.txt) $(cat $HOME/rpi-model.txt)" \
    --menu "\nPlease select from the following:" 18 70 10 \
    "1" "Prológica CP400" \
    "2" "Prológica CP400 Color II" \
    "3" "Novo Tempo Color 64" \
    "4" "ILCE SEP Micro-SEP 1600" \
    "5" "Dynacom MX-1600" \
    "6" "Terco AB 4426 CNC Programming Station" \
    "7" "Tandy Videotex" \
    "8" "Matra Alice" \
    "9" "Matra Alice 32" \
    "10" "Matra Alice 90" \
    "11" "Matra Alice 128K (MCX-BASIC)" \
    "12" "Elanco AgVision" \
    "13" "Return to Main Menu" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) cp400.sh;;
        2) cp400c2.sh;;
        3) lzcolor64.sh;;
        4) ms1600.sh;;
        5) mx1600.sh;;
        6) t4426.sh;;
        7) trsvidtx.sh;;
        8) alice.sh;;
        9) alice32.sh;;
       10) alice90.sh;;
       11) alice128.sh;;
       12) agvision.sh;;
       13) menu;;
        *) echo "Quitting...";;
    esac
