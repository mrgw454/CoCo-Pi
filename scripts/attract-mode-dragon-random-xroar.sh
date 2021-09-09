#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# select 100 random Dragon 32 cartridges and run them for 120 seconds each

for run in {1..100}
do

file=$(shuf -ezn 1 /media/share1/carts-dragon/* | xargs -0 -n1 echo)

     clear
     echo "Random cartridge $run"
     echo "file = $file"
     sleep 2
     xroar -c $HOME/.xroar/xroar.conf -default-machine dragon32 -timeout 120 -cart-autorun "$file"

done

cd $HOME/.mame

