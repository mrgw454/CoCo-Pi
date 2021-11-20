#!/bin/bash

# script to compile MC-10 BASIC programs (non MCX-BASIC for now) using Greg Dionne's mcbasic compiler.
# It will also create a WAV file for real cassette CLOADM'ing

# syntax example:

# ./compile-BASIC-mc10.sh <FILE.BAS>


# parse command line parameters for standard help options

if [[ $1 =~ --h|--help|-h ]];then

    echo -e
    echo -e "Example syntax:"
    echo -e
    echo -e "./$scriptname <FILE.BAS>"
    echo -e
    exit 1

fi

# set up some variables

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"
workdir=$(pwd)


# compile BASIC program

mcbasic -native $1
echo -e

if [ -f "$workdir/$filename.asm" ]; then

	# assemble object code from compiler
	echo Assembling $filename.asm...
	echo -e
	tasm6801 $filename.asm


	if [ -f "$workdir/$filename.c10" ]; then

		# convert assembled binary into WAV file
		echo Converting $filename.c10 to WAV...
		echo -e
		cas2wav $workdir/$filename.c10 $workdir/$filename.wav

	else

		echo -e
		echo "ERROR - $filename.c10" not found.  Perhaps an assembly issue?
		echo -e
		exit 1

	fi

else

	echo -e
	echo "ERROR - $filename.asm" not found.  Perhaps a compile issue?
	echo -e
	exit 1

fi

ls -l $filename*

echo -e
echo -e "Done."
echo -e

exit 1
 
