#!/bin/bash

clear

echo
echo
echo
echo
echo
echo
echo
echo
echo
echo

echo -e
echo -e "This script will download the latest NitrOS9 EOU build."
echo -e
echo -e "The existing file(s) will be overwritten."
echo -e
echo -e "Press [CTRL-C] to cancel script or ..."
echo -e
read -p "... Press any key to continue." -n1 -s
echo -e
echo -e
echo -e "Downloading latest file..."
echo -e
wget -c -P /media/share1/EMU/EOU "http://lcurtisboyle.com/nitros9/NitrOS9-EOU-6309-LATEST.zip"
wget -c -P /media/share1/EMU/EOU "http://lcurtisboyle.com/nitros9/NitrOS9-EOU-6809-LATEST.zip"

cd /media/share1/EMU/EOU

    echo -e
    unzip -o "/media/share1/EMU/EOU/NitrOS9-EOU-6809-LATEST.zip"
    unzip -o "/media/share1/EMU/EOU/NitrOS9-EOU-6309-LATEST.zip"
    echo -e
    echo -e "Done!"
    echo -e
    read -p "Press any key to continue." -n1 -s

rm "/media/share1/EMU/EOU/NitrOS9-EOU-6309-LATEST.zip"
rm "/media/share1/EMU/EOU/NitrOS9-EOU-6809-LATEST.zip"

cd $HOME/.mame


