#!/bin/bash

echo -e "zenity --info --width=200 --height=50 --title=\"Attract Mode\" --text=\"Click OK to cancel\nAttract Mode.\n\nProcess ID: $$\"; kill $$ &" > /tmp/cancel.sh
chmod a+x /tmp/cancel.sh; /tmp/cancel.sh &

# loop over MC-10 programs and run them for 120 seconds each

for run in {1..100}
do

file=$(shuf -ezn 1 $1/*.c10 | xargs -0 -n1 echo)

     clear
     echo "Random program $run"
     echo "file = $file"
     sleep 2
     xroar -c $HOME/.xroar/xroar.conf -default-machine mc10 -ram 20k -timeout 120 "$file" $XROARPARMS

done

cd $HOME/.mame
