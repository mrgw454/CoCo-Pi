clear

ps_out=`ps -ef | grep pyDriveWire | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "$1")
if [[ "$result" != "" ]];then
    echo -e "pyDriveWire is running"
    echo
else
    echo -e "pyDriveWire is not running"
    echo
    echo -e "Please start pyDriveWire prior to using this command."
    echo

    exit 2
fi


if [ $# -ne 2 ]; then
    echo -e
    echo "No pyDriveWire Instance and/or DRIVE # provided.  Usage: $0 <pyDW instance> <DRIVE #>"
    echo -e
    echo "Current pyDriveWire Instance and mounted Disk(s):"

    $HOME/pyDriveWire/pyDwCli http://localhost:6800 dw instance show
    $HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk show

    exit 2
fi

clear

dwi=$1
declare -i dwd=$2

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw instance select $dwi

floppypath="/media/share1"

echo -e
echo "Current pyDriveWire Instance and mounted Disk(s):"
echo -e
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw instance show
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk show

read -p "Press any key to continue... " -n1 -s


function fileChooser(){
  local __DIR=$1
  local __RESULT=$(dialog --clear --title "pyDriveWire DSK image browser" --stdout \
                   --title "pyDriveWire DSK mounter - choose file"\
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

$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk eject $dwd
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk insert $dwd "$RESULT"
$HOME/pyDriveWire/pyDwCli http://localhost:6800 dw disk show

read -p "Press any key to continue... " -n1 -s
echo -e

cd $HOME/.mame
