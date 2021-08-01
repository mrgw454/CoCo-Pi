# select 100 random MC-10 titles and run them for 120 seconds each

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

shopt -s extglob

for run in {1..100}
do

file=$(shuf -ezn 1 /media/share1/software/mc10/* | xargs -0 -n1 echo)

     clear
     echo
     echo
     echo
     echo
     echo
     echo
     echo
     echo

     echo "Random title $run"
     echo "file = $file"
     echo
     echo "Press [CTRL][C] to BREAK out of ATTRACT mode."
     echo
     echo echo Press [F10] to toggle the no throttle option (helps speed things up)
     sleep 2
     mame mc10 -ramsize 20K ${file//+(*\/|.*)} -seconds_to_run 120 $MAMEPARMS

done

cd $HOME/.mame
