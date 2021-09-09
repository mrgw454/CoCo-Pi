#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# select random Coco 2 program and run for 120 seconds each

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

cp $HOME/.mame/cfg/coco2.cfg.beckerport-disabled $HOME/.mame/cfg/coco2.cfg

shopt -s extglob
shopt -s nocasematch

for run in {1..100}
do

file=$(shuf -ezn 1 $1/* | xargs -0 -n1 echo)

     clear
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo

     echo "Random program $run"
     echo "file = $file"
     echo
     echo "Press [CTRL][C] to BREAK out of ATTRACT mode."
     echo
     echo "Press [F10] to toggle the no throttle option (helps speed things up)."
     sleep 2

     if [[ $file == *.dsk ]]; then

	imgtool dir coco_jvc_rsdos "$file"
	echo -e

	program=$(imgtool dir coco_jvc_rsdos "$file" | grep -E '.BAS' | grep -m 1 -o '^[^ ]*')
	echo -e

	# BASIC program
	if [[ ${program:(-4)} == '.BAS' ]]; then

		echo Program to run/execute: $program
		sleep 2
		mame coco2 -ram 64k -flop1 "$file" -seconds_to_run 120 -autoboot_delay 2 -autoboot_command "RUN \"$program\"\n" $MAMEPARMS
		BAS=1

	fi



	if [[ $BAS != 1 ]]; then
		program=$(imgtool dir coco_jvc_rsdos "$file" | grep -E '.BIN' | grep -m 1 -o '^[^ ]*')
		echo -e

		# BINARY program
		if [[ ${program:(-4)} == '.BIN' ]]; then

			echo Program to run/execute: $program
			sleep 2
			mame coco2 -ram 64k -flop1 "$file" -seconds_to_run 120 -autoboot_delay 2 -autoboot_command "LOADM \"$program\":EXEC\n" $MAMEPARMS

		fi
	fi


     fi


     if [[ $file == *.ccc ]]; then

	mame coco2 -ram 64k -cart "$file" -seconds_to_run 120 $MAMEPARMS

     fi


     if [[ $file == *.zip ]]; then

	mame coco2 "$file" -ram 64k -seconds_to_run 120 $MAMEPARMS

     fi


# capture MAME ERRORLEVEL

if [ $? -eq 0 ]
then
        echo
else
        echo
        echo "Please make note of message above when requesting help."
        echo
        read -p  "Press any key to continue." -n1 -s
fi

BAS=0

done

cd $HOME/.mame
