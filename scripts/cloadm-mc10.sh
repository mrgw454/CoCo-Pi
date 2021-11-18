clear

wavpath="/media/share1"

function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "MC-10 WAV browser" --stdout \
                   --title "MC-10 WAV browser - choose file"\
                   --fselect $__DIR 14 58)

  echo $__RESULT
}

RESULT=$( fileChooser "$wavpath/" )

while [ -d "$RESULT" ]
do
  RESULT=$( fileChooser "$RESULT/" )
done

# Print selection

clear

echo -e "File selected: $RESULT"
echo -e
echo -e

# now we can use the selected file
echo -e
echo Make sure to type CLOAD/CLOADM on your MC-10 prior to continuing.
echo -e
read -p "Press any key to continue... " -n1 -s
echo -e
echo -e

omxplayer -o local "$RESULT"

echo -e
echo -e
echo "$RESULT" was sent to the RPi analog audio port.
echo -e
echo You should be able to type RUN or EXEC on the MC-10 to start program.
echo -e
read -p "Press any key to continue... " -n1 -s

echo -e
cd $HOME/.mame
