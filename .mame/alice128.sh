clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# Use this for a Alice with MCX-128 expansion.  Make to set the baud rate to 38,400 in MAME using the UI (Machine Configuration).  The .pydrivewire config file will need this section:

# [connect]
# option connect True
# option host localhost
# option port 6809

mame alice -ext alice128 -rs232 null_modem -bitb socket.localhost:6809 $MAMEPARMS > /dev/null

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
CoCoPi-menu-Clones.sh
