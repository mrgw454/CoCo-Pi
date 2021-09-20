#!/bin/bash

# script to update Jim Gerrie's MC-10 repository from github repo
if [ -d $HOME/source/trs80mc10 ]
then
    echo git repo exists.  Updating...
    echo
    cd $HOME/source/trs80mc10
    git pull
    echo
else
    echo git repo does not exist.  Cloning and updating...
    echo
    cd $HOME/source
    git clone https://github.com/jggames/trs80mc10.git
    echo
fi

# check for existing symlink
if [ -L /media/share1/JIMG ]
then
    echo symlink already exists.
    echo
else
    echo symlink does not exist.  Creating...
    echo
    rm  -r -f /media/share1/JIMG
    ln -s "$HOME/source/trs80mc10/quicktype/Latest_Jim_G_MC-10_Compilation" /media/share1/JIMG
    echo
fi

cd $HOME/.mame

echo -e
echo -e
read -p "Press any key to continue... " -n1 -s
echo -e
