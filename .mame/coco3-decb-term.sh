clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# disable Becker port
cp $HOME/.mame/cfg/coco3h.cfg.beckerport-disabled $HOME/.mame/cfg/coco3h.cfg

# Use this for a Coco 3 using a Deluxe RS-232 Pak and MultiPak Interface at 9600 baud.  Make sure to match the baud rate in MAME using the UI (Machine Configuration).  tcpser needs to be set for 2400 baud for this to work.
# twi-term requires TANDY for RS232 type and GIME for interrupt type in RS232C settings.
mame coco3h -ramsize 512k -ext multi -ext:multi:slot1 rs232 -ext:multi:slot1:rs232:port null_modem -bitb socket.localhost:6551 -flop1 /media/share1/SDC/COMM/TWITERM.DSK -autoboot_delay 2 -autoboot_command 'LOADM"TWI-TERM.BIN":EXEC\n' $MAMEPARMS > /dev/null

# Not working at the moment
#mame coco3 -ramsize 512k -ext multi -ext:multi:slot1 rs232 -ext:multi:slot1:rs232:port null_modem -bitb socket.localhost:6551 -flop1 /media/share1/SDC/TAYLOR/netmate.dsk -autoboot_delay 2 -autoboot_command 'LOADM"NET.BIN"\n' $MAMEPARMS -debug > /dev/null

# capture MAME ERRORLEVEL

if [ $? -eq 0 ]
then
        echo
else
        echo
        echo "Please make note of message above when requesting help."
        echo
        read -p  "Press any key to continue." -n1 -s
fi

cd $HOME/.mame
CoCoPi-menu-Coco3.sh
