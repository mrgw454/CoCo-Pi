#!/bin/bash

# check for existing coco-hash project files folder
if [ -d $HOME/source/coco-hash ]
then
    echo coco-hash project folder exists.
    echo
else
    echo coco-hash project folder does not exist.  Please perform an "Update CoCo-Pi from git repo"
    echo and try this command again.  Aborting.
    echo
    echo
    read -p "Press any key to continue... " -n1 -s
    exit 1
fi


# check for existing disk software files in coco_flop folder
if [ -d $HOME/source/coco-hash/software/coco_flop ]
then
    echo coco_flop disk software files exist.
    echo
else
    echo coco_flop disk software files do not exist.  Please run coco-hash process to download and generate
    echo the correct CoCo disk software and MAME hash file.  More information can be found here:
    echo
    echo Aborting.
    echo
    echo
    read -p "Press any key to continue... " -n1 -s
    exit 1
fi





# check for existing of symlink folder
if [ -L /media/share1/software/coco_flop ]
then
    echo software symlink folder exists.
    echo
else
    echo software symlink folder does not exist.  Creating...
    echo
	rm  -r -f /media/share1/software/coco_flop
    ln -s $HOME/source/coco-hash/software/coco_flop /media/share1/software/coco_flop
    echo
fi


if [ -L $HOME/.mame/hash/coco_flop.xml ]
then
    echo hash file symlink exists.
    echo
else
    echo hash file does not exist.  Creating...
    echo
	rm  -r -f $HOME/.mame/hash/coco_flop.xml
    ln -s $HOME/source/coco-hash/hash/coco_flop.xml $HOME/.mame/hash/coco_flop.xml
    echo
fi


cd $HOME/.mame

echo -e
echo -e
read -p "Press any key to continue... " -n1 -s
echo -e
