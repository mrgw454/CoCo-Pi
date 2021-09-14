#!/bin/bash

# script to update Ron Delvaux's picture gallery from github repo
if [ -d $HOME/source/RonD/BMP ]
then
    echo git repo exists.  Updating...
    echo
    cd $HOME/source/RonD
    git pull
    echo
else
    echo git repo does not exist.  Cloning and updating...
    echo
    cd $HOME/source
    https://github.com/mrgw454/RonD.git
    echo
fi


# check for existing of symlink folder
if [ -L /media/share1/RonD/BMP ]
then
    echo symlink folder exists.
    echo
else
    echo symlink folder does not exist.  Creating...
    echo
	rm  -r -f /media/share1/RonD/BMP
    ln -s $HOME/source/RonD/BMP /media/share1/RonD/BMP
    echo
fi

cd $HOME/.mame

echo -e
echo -e
read -p "Press any key to continue... " -n1 -s
echo -e
