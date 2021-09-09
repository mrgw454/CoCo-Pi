#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# loop over Coco cartridges and run them for 120 seconds each

OIFS="$IFS"
IFS=$'\n'
for file in `find /media/share1/carts -type f -name "*.ccc"`  
do
     clear
     echo "file = $file"
     sleep 2
     xroar -c $HOME/.xroar/xroar.conf -default-machine coco2bus -timeout 120 -cart-autorun "$file"
done
IFS="$OIFS"

cd $HOME/.mame

