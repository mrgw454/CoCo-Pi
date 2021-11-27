clear

echo -e "This setting will toggle (enable/disable) the updating of the /boot/config.txt file" > msg.txt
echo -e >> msg.txt
echo -e "If enabled, the /boot/config/txt can/will be updated each time the Run CoCo-Pi fix script is selected." >> msg.txt
echo -e "If disabled, the /boot/config/txt will NOT be updated each time the Run CoCo-Pi fix script is selected." >> msg.txt
echo -e >> msg.txt
echo -e >> msg.txt

whiptail --title "Toggle /boot/config.txt file" --textbox msg.txt 0 0
rm msg.txt

if [ -e $HOME/update/.fix-cocopi-skip-config-clobber ]
then

    echo .fix-cocopi-skip-config-clobber file found.  Disabling...
    echo
    rm $HOME/update/.fix-cocopi-skip-config-clobber

else

    echo .fix-cocopi-skip-config-clobber file not found.  Enabling...
    echo
    touch $HOME/update/.fix-cocopi-skip-config-clobber

fi

echo
read -p "Press any key to continue." -n1 -s

cd $HOME/.mame
