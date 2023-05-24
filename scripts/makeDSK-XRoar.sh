#!/bin/bash

# script to create a new Coco floppy disk image and and copy all Coco related files to it.
# It will also (optionally) run XRoar and mount the disk image (pyDriveWire or normal DECB)

# this script can take up to 2 command line parameters:
# System to use for XRoar (i.e. coco2 coco2b, coco2bus) and use pyDriveWire (yes or no)

# syntax example:

# ./makeDSK coco2 y

# this will create a new disk image and copy all Coco compatible files to a disk image
# using name of the current folder.  In addition, it will launch XRoar (with HDBDOS)
# and use pyDriveWire with this disk image mounted as DRIVE 0.
# If pyDriveWire is not running, the script will start it.

# Define function for displaying error codes from Toolshed's 'decb' command

functionErrorLevel() {

        if [ $? -eq 0 ]
	then

                echo -e "Successfully copied file to DSK image."
                echo -e

        else

                echo -e "Error during copy process to DSK image."
                echo -e
                # read -p "Press any key to continue... " -n1 -s
		echo -e
		echo -e

        fi

}

# use parameter file for XRoar (if found)
XROARPARMSFILE=`cat $HOME/.xroar/.optional_xroar_parameters.txt`
export XROARPARMS=$XROARPARMSFILE

# get name of script and place it into a variable
scriptname=`basename "$0"`


# get name of current folder and place it into a variable
floppy=`basename "$PWD"`

workdir=$(pwd)


# parse command line parameters for standard help options

if [[ $1 =~ --h|--help|-h ]];then

    echo -e
    echo -e "Example syntax:"
    echo -e
    echo -e "./$scriptname <coco driver> <y>|<n>"
    echo -e
    exit 1

fi


# if a previous disk image exists, move into a date-time named folder

if [ -f "$floppy.DSK" ]; then

	foldername=$(date +%Y-%m-%d_%H.%M.%S)

	mkdir "$foldername"

	mv "$floppy.DSK" "$foldername"

	echo -e Archiving existing disk image ["$floppy.DSK"] into backup folder ["$foldername"]
	echo -e
	echo -e
fi

# create new DSK image based on current folder name

echo -e Creating new floppy disk image [$floppy.DSK]
echo -e

decb dskini "$floppy.DSK"

# ignore file extension case
shopt -s nocasematch

for f in *; do

	# Copy all BASIC files (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.BAS ]]; then

		echo -e decb copy -0 -a -t -r "$f" "$floppy.DSK","${f^^}"
		decb copy -0 -a -t -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


	# Copy all BINARY files (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.BIN ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


	# Copy all TEXT files (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.TXT ]]; then

		echo -e decb copy -3 -a -r "$f" "$floppy.DSK","${f^^}"
		decb copy -3 -a -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


	# Copy all DAT files (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.DAT ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


	# Copy all ROM files (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.ROM ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


	# Copy all CHR files for CoCoVGA (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.CHR ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


# Copy all VG6 files for CoCoVGA (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.VG6 ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


# Copy all SCR files for CoCoVGA (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.SCR ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


# Copy all PNG files for ugBasicA (and convert names to UPPERCASE) to DSK image
	if [[ $f == *.PNG ]]; then

		echo -e decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		decb copy -2 -b -r "$f" "$floppy.DSK","${f^^}"
		functionErrorLevel

	fi


done

echo -e

# list disk image contents

decb dir "$floppy.DSK"
echo -e


# if no parameters, only make disk image and exit

if [ $# -eq 0 ]
  then
    echo -e "Only made disk image as no command line parameters supplied"

	echo -e
	echo -e "Done."
	echo -e

	exit 1

fi



# (optional) load XRoar and mount disk image in pyDrivewire INSTANCE 0 as DRIVE 0

if [[ $2 =~ Y|y ]];then

	# copy to /media/share1/DW4 so the disk image can be sync'd to other DriveWire servers

	echo "Copying file to [/media/share1/DW4/$floppy/$floppy.DSK] so it can be sync'd to other DriveWire servers..."
	echo -e

	mkdir "/media/share1/DW4/$floppy"
	cp "$floppy.DSK" "/media/share1/DW4/$floppy"

	echo -e


	# make sure HDBDOS is used for pyDriveWire access


	# Coco 2 section

	if [[ $1 =~ coco2|coco2b|coco2bus ]];then

		# eject disk from pyDriveWire
		$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
		echo -e

		# insert disk for pyDriveWire
		$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 0 "$workdir/$floppy.DSK"
		echo -e

		# show (confirm) disk mounted in pyDriveWire
		$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk show 0
		echo -e

		xroar -c $HOME/.xroar/xroar.conf -default-machine coco2bus -machine-cart hdbdos $XROARPARMS

		# eject disk from pyDriveWire
		$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0

                echo -e
                echo -e "Done."
                echo -e
                exit 1

	fi


	# Coco 3 section

	if [[ $1 =~ coco3 ]];then

        # eject disk from pyDriveWire
        $HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0
        echo -e

        # insert disk for pyDriveWire
        $HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert 0 "$workdir/$floppy.DSK"
        echo -e

        # show (confirm) disk mounted in pyDriveWire
        $HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk show 0
        echo -e

		xroar -c $HOME/.xroar/xroar.conf -default-machine coco3 -machine-cart hdbdos $XROARPARMS		
	
		# eject disk from pyDriveWire
		$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject 0

		echo -e
		echo -e "Done."
		echo -e
		exit 1

	fi


	echo -e
	echo -e "Not a valid Coco based driver for DriveWire.  Exiting."
	echo -e
	echo -e "Some valid Coco drivers for XRoar are:"
	echo -e
	echo -e "coco2, coco2b, coco2bus, coco3"

	echo -e
	echo -e "Done."
	echo -e
	exit 1

else


	# (optional) load XRoar and mount the disk image as DRIVE 0

	# Coco 2 and Coco 3 section

	if [[ $1 =~ coco2|coco2b|coco2bus|coco3 ]];then

    #cd $HOME/.xroar
    xroar -c $HOME/.xroar/xroar.conf -default-machine $1 -load "$PWD/$floppy.DSK" $XROARPARMS

		echo -e
		echo -e "Done."
		echo -e

		exit 1

	fi

	echo -e
	echo -e "Not a valid Coco based driver.  Exiting."
	echo -e
	echo -e "Some valid Coco drivers for XRoar are:"
	echo -e
	echo -e "coco2, coco2b, coco2bus, coco3"

	echo -e
	echo -e "Done."
	echo -e

	exit 1

fi

	echo -e
	echo -e "Done."
	echo -e

	exit 1
