# loop over Coco 1/2 cartridges and run them for 60 seconds each

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

shopt -s extglob

for f in `ls /media/share1/software/coco_cart/*.zip`

	do 
		clear
                echo
                echo
                echo
                echo
                echo
                echo
                echo
                echo

		echo file = "$f"
                echo
                echo "Press [CTRL][C] to BREAK out of ATTRACT mode."
		echo
		echo "Press [F10] to toggle the no throttle option (helps speed things up)."
		sleep 2
		mame coco2 ${f//+(*\/|.*)} -seconds_to_run 60 $MAMEPARMS
	done

cd $HOME/.mame

