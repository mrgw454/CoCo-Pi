echo -n "\033]2;menu\007"

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
    --menu "\nPlease select from the following:" 18 65 10 \
    "1" "TRS-80 Color Computer 2 Menu" \
    "2" "TRS-80 Color Computer 2 Menu (XRoar)" \
    "3" "Tandy  Color Computer 3 Menu" \
    "4" "Tandy  Color Computer 3 Menu (XRoar) WIP!" \
    "5" "Tandy  Color Computer 3 Menu (OVCC)" \
    "6" "TRS-80 MC-10 Menu" \
    "7" "Dragon Menu" \
    "8" "Dragon Menu (XRoar)" \
    "9" "Utilities Menu" \
    "10" "Internet/Online Menu" \
    "11" "Attract (Kiosk) Mode Menu" \
    "12" "Shutdown Raspberry Pi" \
    3>&1 1>&2 2>&3)

    # Below you can enter the corresponding commands

    case $RETVAL in
        1) CoCoPi-menu-Coco2.sh;;
        2) CoCoPi-menu-Coco2-XRoar.sh;;
        3) CoCoPi-menu-Coco3.sh;;
        4) CoCoPi-menu-Coco3-XRoar.sh;;
        5) CoCoPi-menu-Coco3-OVCC.sh;;
        6) CoCoPi-menu-MC10.sh;;
        7) CoCoPi-menu-Dragon.sh;;
        8) CoCoPi-menu-Dragon-XRoar.sh;;
        9) CoCoPi-menu-Utilities.sh;;
       10) CoCoPi-menu-Online.sh;;
       11) CoCoPi-menu-Attract.sh;;
       12) shutdownRPi.sh;;
        *) echo "Quitting...";;
    esac
