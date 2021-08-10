# select 100 random Coco 1/2 cartridges and run them for 120 seconds each

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

cp $HOME/.mame/cfg/coco2.cfg.beckerport-disabled $HOME/.mame/cfg/coco2.cfg

shopt -s extglob

for run in {1..100}
do

file=$(shuf -ezn 1 /media/share1/software/coco_cart/* | xargs -0 -n1 echo)

     clear
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo

     echo "Random cartridge $run"
     echo "file = $file"
     echo
     echo "Press [CTRL][C] to BREAK out of ATTRACT mode."
     echo
     echo "Press [F10] to toggle the no throttle option (helps speed things up)."
     sleep 2
     mame coco2 ${file//+(*\/|.*)} -seconds_to_run 120 $MAMEPARMS

done

cd $HOME/.mame

