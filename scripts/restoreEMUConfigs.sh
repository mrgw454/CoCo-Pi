clear

echo -e "Restore Emulator configuration file(s) from latest archive" > msg.txt
echo -e >> msg.txt
echo -e "This script will restore an archived copy of your most recent" >> msg.txt
echo -e "backup /media/share1/backupEMUConfigs.tar.gz." >> msg.txt
echo -e >> msg.txt
echo -e "WARNING - this will overwrite any existing configuration file(s)!" >> msg.txt
echo -e >> msg.txt
echo -e >> msg.txt

whiptail --title "Restore Emulator Configuration File(s)" --textbox msg.txt 0 0
rm msg.txt

if [ -e /media/share1/backupEMUConfigs.tar.gz ]
then

	read -p "Press any key to continue to continue or [CTRL-C] to abort." -n1 -s
        tar xzvf /media/share1/backupEMUConfigs.tar.gz -C /
	echo
	read -p "Restore complete.  Press any key to continue." -n1 -s

else

        echo
        echo
        echo
        echo "No archived Emulator configuration file(s) found."
        echo
        read -p  "Press any key to continue." -n1 -s

fi

cd $HOME/.mame

