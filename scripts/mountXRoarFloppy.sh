clear

if [ -e $HOME/.xroar/.xroar_floppy ]
then
    floppy=`cat $HOME/.xroar/.xroar_floppy`

    if [ -e "$floppy" ]
    then
         floppypath="$(dirname $floppy)"

         echo "Current floppy drive image exists: $floppy"
         echo -e
         read -p "Press any key to mount a new floppy disk image or [CTRL-C] to exit. " -n1 -s
    else
         rm $HOME/.xroar/.xroar_floppy
	 floppypath="/media/share1"
    fi
fi

function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "XRoar DSK image browser" --stdout \
                   --title "XRoar DSK mounter - choose file"\
                   --fselect $__DIR 14 58)

  echo $__RESULT
}

RESULT=$( fileChooser "$floppypath/" )

while [ -d "$RESULT" ]
do
  RESULT=$( fileChooser "$RESULT/" )
done

# Print selection

clear

echo -e "File selected: $RESULT"
echo -e
echo -e

echo $RESULT > $HOME/.xroar/.xroar_floppy

read -p "Press any key to continue... " -n1 -s

echo -e

cd $HOME/.mame

