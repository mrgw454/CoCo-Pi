clear

if [ $# -ne 2 ]; then
    echo -e
    echo "No Drivewire Instance and/or DRIVE # provided.  Usage: $0 <DW instance> <DRIVE #>"
    echo -e
    echo "Current list of Drivewire Instances:"
    echo -e

    grep 'instance category' $HOME/DriveWire4/config.xml > /tmp/DWInstances-temp.txt
    grep name /tmp/DWInstances-temp.txt | cut -d= -f4 | tr -d '>' > /tmp/DWInstances.txt
    nl -v 0 /tmp/DWInstances.txt
    echo -e

    rm /tmp/DWInstances-temp.txt
    rm /tmp/DWInstances.txt

    exit 2
fi

dwi=$1
declare -i dwd=$2

floppypath="/media/share1"

echo -e
echo "Current Drivewire Instance for $dwi:"
echo -e
java -jar $HOME/DriveWire4/DW4CLI.jar --instance="$dwi" -command='dw disk show '"$dwd"
echo -e
read -p "Press any key to continue... " -n1 -s


function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "Drivewire DSK image browser" --stdout \
                   --title "Drivewire DSK mounter - choose file"\
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
echo $dwi : $dwd
echo -e

java -jar $HOME/DriveWire4/DW4CLI.jar --instance="$dwi" -command='dw disk eject '"$dwd"
java -jar $HOME/DriveWire4/DW4CLI.jar --instance="$dwi" -command='dw disk insert '"$dwd $RESULT"
echo -e
java -jar $HOME/DriveWire4/DW4CLI.jar --instance="$dwi" -command='dw disk show '"$dwd"
echo -e

read -p "Press any key to continue... " -n1 -s

echo -e

cd $HOME/.mame

