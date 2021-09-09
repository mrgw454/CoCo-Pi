#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# loop over Dragon 32 cartridges and run them for 120 seconds each

OIFS="$IFS"
IFS=$'\n'
for file in `find /media/share1/carts-dragon -type f -name "*.rom"`  
do
     clear
     echo "file = $file"
     sleep 2
     xroar -c $HOME/.xroar/xroar.conf -default-machine dragon32 -timeout 120 -cart-autorun "$file"
done
IFS="$OIFS"

cd $HOME/.mame

