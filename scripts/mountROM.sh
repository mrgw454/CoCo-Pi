clear

if [ -e $HOME/.mame/.mame_rom ]
then
    ROM=`cat $HOME/.mame/.mame_rom`

    if [ -e "$rom" ]
    then
         ROMpath="$(dirname $rom)"

         echo "Current ROM image exists: $rom"
         echo -e
         read -p "Press any key to mount a new ROM image or [CTRL-C] to exit. " -n1 -s
    else
         rm $HOME/.mame/.mame_rom
	 ROMpath="/media/share1/roms"
    fi
fi

function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "MAME ROM image browser" --stdout \
                   --title "MAME ROM mounter - choose file"\
                   --fselect $__DIR 14 58)

  echo $__RESULT
}

RESULT=$( fileChooser "$ROMpath/" )

while [ -d "$RESULT" ]
do
  RESULT=$( fileChooser "$RESULT/" )
done

# Print selection

clear

echo -e "File selected: $RESULT"
echo -e
echo -e

echo $RESULT > $HOME/.mame/.mame_rom

read -p "Press any key to continue... " -n1 -s

echo -e

cd $HOME/.mame

