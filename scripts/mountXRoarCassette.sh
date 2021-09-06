clear

if [ -e $HOME/.xroar/.xroar_cassette ]
then
    cassette=`cat $HOME/.xroar/.xroar_cassette`

    if [ -e "$cassette" ]
    then
         cassettepath="$(dirname $cassette)"

         echo "Current cassette image exists: $cassette"
         echo -e
         read -p "Press any key to mount a new cassette image or [CTRL-C] to exit. " -n1 -s
    else
         rm $HOME/.xroar/.xroar_cassette
	 cassettepath="/media/share1/cassette"
    fi
fi

function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "XRoar cassette image browser" --stdout \
                   --title "XRoar cassette mounter - choose file"\
                   --fselect $__DIR 14 58)

  echo $__RESULT
}

RESULT=$( fileChooser "$cassettepath/" )

while [ -d "$RESULT" ]
do
  RESULT=$( fileChooser "$RESULT/" )
done

# Print selection

clear

echo -e "File selected: $RESULT"
echo -e
echo -e

echo $RESULT > $HOME/.xroar/.xroar_cassette

read -p "Press any key to continue... " -n1 -s

echo -e

cd $HOME/.mame

