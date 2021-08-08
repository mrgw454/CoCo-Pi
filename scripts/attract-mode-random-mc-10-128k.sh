# select random MC-10 program and run for 120 seconds each

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

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
     program=$(basename $file)
     echo "file = $program"
     echo
     echo "Press [CTRL][C] to BREAK out of ATTRACT mode."
     echo
     echo "Press [F10] to toggle the no throttle option (helps speed things up)."
     sleep 2

     if [[ $file == *.C10 ]]; then

	echo Program to run/execute: $file
	sleep 2
	mame mc10 -ext mcx128 -rs232 null_modem -bitb socket.localhost:6809 -seconds_to_run 120 -autoboot_delay 2 -autoboot_command "1          \nRUN \"$program\"\n" $MAMEPARMS > /dev/null
	BAS=1

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
