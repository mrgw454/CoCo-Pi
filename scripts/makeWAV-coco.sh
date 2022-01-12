#!/bin/bash

# script to create a new CoCo WAV image and and copy CoCo related files to it.
# It will also (optionally) run MAME mount the WAV image

# syntax example:

# ./makeWAV-coco.sh

# Define function for displaying error codes from Toolshed's 'cecb' command

functionErrorLevel() {

        if [ $? -eq 0 ]
	then

                echo -e "Successfully copied file to WAV image."
                echo -e

        else

                echo -e "Error during copy process to WAV image."
                echo -e
                # read -p "Press any key to continue... " -n1 -s
		echo -e
		echo -e

        fi

}

# use parameter file for MAME (if found)
MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

# get name of script and place it into a variable
scriptname=`basename "$0"`


# get name of current folder and place it into a variable
cassette=`basename "$PWD"`

workdir=$(pwd)


# parse command line parameters for standard help options

if [[ $1 =~ --h|--help|-h ]];then

    echo -e
    echo -e "Example syntax:"
    echo -e
    echo -e "./$scriptname <CoCo driver>"
    echo -e
    exit 1

fi


# if a previous WAV image exists, move into a date-time named folder

if [ -f "$cassette.WAV" ]; then

	foldername=$(date +%Y-%m-%d_%H.%M.%S)

	mkdir "$foldername"

	mv "$cassette.WAV" "$foldername"

	echo -e Archiving existing cassette image ["$cassette.WAV"] into backup folder ["$foldername"]
	echo -e
	echo -e
fi

# create new WAV image based on current folder name

echo -e Creating new cassette image [$cassette.WAV]
echo -e

cecb bulkerase "$cassette.WAV"

# ignore file extension case
shopt -s nocasematch

for f in *; do

	# Copy all BASIC files (and convert names to UPPERCASE) to WAV file
	if [[ $f == *.BAS ]]; then

		echo -e cecb copy -0 -a -l -t -g "$f" "$cassette.WAV","${cassette^^}"
		cecb copy -0 -a -l -t -g "$f" "$cassette.WAV","${cassette^^}"
		functionErrorLevel

	fi


	# Copy all BINARY files (and convert names to UPPERCASE) to WAV file
	if [[ $f == *.BIN ]]; then

		echo -e cecb copy -2 -b -g "$f" "$cassette.WAV","${f%%.*}"
		cecb copy -2 -b -g "$f" "$cassette.WAV","${f%%.*}"
		functionErrorLevel

	fi

done

echo -e

# list cassette image contents

#cecb fstat "$cassette.WAV","${cassette^^}"
echo -e


# if no parameters, only make disk image and exit

if [ $# -eq 0 ]
  then
    echo -e "Only made cassette image as no command line parameters supplied"

	echo -e
	echo -e "Done."
	echo -e

	exit 1

fi



# (optional) load MAME and mount cassette image

if [[ $1 =~ coco|coco2|coco2b|coco2bh|coco3|coco3h|cocoe|cocoeh|cocoh ]] ;then

		mame -homepath $HOME/.mame $1 -cass "$PWD/$cassette.WAV" $MAMEPARMS

		echo -e
		echo -e "Done."
		echo -e

		exit 1

fi


#	echo -e
#	echo -e "Not a valid CoCo based driver.  Exiting."
#	echo -e
#	echo -e "Some valid CoCo drivers for MAME are:"
#	echo -e
#	mame -listfull | grep \""Color Computer"
#
#	echo -e
#	echo -e "Done."
#	echo -e
#
#	exit 1



	echo -e
	echo -e "Done."
	echo -e

	exit 1
