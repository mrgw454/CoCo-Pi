#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# select random Coco 2 program and run for 120 seconds each

cd $HOME/.xroar

XROARPARMSFILE=`cat $HOME/.xroar/.optional_xroar_parameters.txt`
export XROARPARMS=$XROARPARMSFILE

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

     echo "Random disk $run"
     echo "file = $file"
     echo
     echo "Press [CTRL][C] to BREAK out of ATTRACT mode."
     echo
     echo "Press [SHIFT][F12] to toggle the no throttle option (helps speed things up)."
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
		xroar -c $HOME/.xroar/xroar.conf -machine coco2bus -timeout 120 $XROARPARMS -cart mpi -mpi-load-cart 3=rsdos -mpi-slot 3 -load "$file" -type 'RUN "'$program'"\r'
		BAS=1

	fi



	if [[ $BAS != 1 ]]; then
		program=$(imgtool dir coco_jvc_rsdos "$file" | grep -E '.BIN' | grep -m 1 -o '^[^ ]*')
		echo -e

		# BINARY program
		if [[ ${program:(-4)} == '.BIN' ]]; then

			echo Program to run/execute: $program
			sleep 2
			xroar -c $HOME/.xroar/xroar.conf -machine coco2bus -timeout 120 $XROARPARMS -cart mpi -mpi-load-cart 3=rsdos -mpi-slot 3 -load "$file" -type 'LOADM "'$program'"\rEXEC/r'

		fi
	fi

     fi


     if [[ $file == *.ccc ]]; then

	xroar -c $HOME/.xroar/xroar.conf -default-machine coco2bus -timeout 120 $XROARPARMS -cart-autorun "$file"
     fi


# capture XRoar ERRORLEVEL

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
