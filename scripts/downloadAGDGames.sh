#!/bin/bash

clear

# set current SDC image filename
export SDCIMAGE=https://colorcomputerarchive.com/repo/Disks/Coco%20SDC/Games/AGD%20Games%20%28Pere%20Serrat%29%20%28Ports%20from%20ZX%20Spectrum%29%20%28Coco%20SDC%29.zip

echo
echo
echo
echo
echo
echo
echo
echo

echo -e
echo -e "This script will download the 'AGD Games (Pere Serrat) (Ports from ZX Spectrum) (Coco SDC)."
echo -e
echo -e "Please make a backup of all your files in /media/share1/SDC/AGD"
echo -e "as any existing file(s) will be overwritten."
echo -e
echo -e "Press [CTRL-C] to cancel script or ..."
echo -e
read -p "... Press any key to continue." -n1 -s
echo -e
echo -e
echo -e "Downloading AGD Image file..."
echo -e
wget --no-use-server-timestamps -c -P /media/share1/SDC $SDCIMAGE

cd /media/share1/SDC

    echo -e "Extracting files into /media/share1/SDC/AGD..."
    echo -e
    fn=$(ls -t | head -n1)

    unzip -j -o "$fn" -d /media/share1/SDC/AGD
    echo -e
    echo -e "Done!"
    echo -e
    read -p "Press any key to continue." -n1 -s

rm "$fn"

cd $HOME/.mame


