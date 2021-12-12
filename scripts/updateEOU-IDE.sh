#!/bin/bash

# script to update Michael Furman's EOU for IDE project from github repo
if [ -d $HOME/source/eou_ide ]
then
    echo git repo exists.  Updating...
    echo
    cd $HOME/source/eou_ide
    git pull
    echo
else
    echo git repo does not exist.  Cloning and updating...
    echo
    cd $HOME/source
    git clone https://github.com/n6il/eou_ide
    echo
fi


# check for existing of NitrOS9 EOU HDD files
if [ -f /media/share1/EMU/EOU/63SDC.VHD ]
then
    echo EOU HDD files exist.
    echo

else
    echo EOU HDD files do not exist.  Please select
    echo Download Latest NitrOS9 EOU Image from Download Utilities Menu
    echo prior to using this script.
    echo

    echo -e
    read -p "Press any key to continue... " -n1 -s
    exit

fi


# create EOU IDE based HDD file (overwrite if it already exists)...

if [ -f $HOME/source/eou_ide/63IDE.ide ]
    then
    rm $HOME/source/eou_ide/63IDE.*
fi

echo Creating EOU IDE based HDD image file...
cd $HOME/source/eou_ide
cp /media/share1/EMU/EOU/63SDC.VHD ./
python ./makebootfileide.py -c 6309 -i $HOME/source/eou_ide/63SDC.VHD

    if [ -f $HOME/source/eou_ide/63IDE.ide ]
    then
    echo
    echo EOU IDE HDD image created successfully for use with XRoar.
    echo
    fi

cd $HOME/.mame

echo -e
echo -e
read -p "Press any key to continue... " -n1 -s
echo -e
