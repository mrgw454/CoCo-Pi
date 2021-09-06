clear

if [ -e $HOME/.xroar/.xroar_bin ]
then
    bin=`cat $HOME/.xroar/.xroar_bin`

    if [ -e "$bin" ]
    then
         binpath="$(dirname $bin)"

         echo "Current BIN image exists: $bin"
         echo -e
         read -p "Press any key to mount a new BIN image or [CTRL-C] to exit. " -n1 -s
    else
         rm $HOME/.xroar/.xroar_bin
	 binpath="/media/share1"
    fi
fi

function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "XRoar BIN image browser" --stdout \
                   --title "XRoar BIN mounter - choose file"\
                   --fselect $__DIR 14 58)

  echo $__RESULT
}

RESULT=$( fileChooser "$binpath/" )

while [ -d "$RESULT" ]
do
  RESULT=$( fileChooser "$RESULT/" )
done

# Print selection

clear

echo -e "File selected: $RESULT"
echo -e
echo -e

echo $RESULT > $HOME/.xroar/.xroar_bin

read -p "Press any key to continue... " -n1 -s

echo -e

cd $HOME/.mame

