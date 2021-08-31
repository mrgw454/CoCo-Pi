clear

infodate=$(date +%Y-%m-%d_%H.%M.%S)

# if previous RPi info file exists, delete it first
if [ -e /tmp/rpi-info.txt ]
then
        rm /tmp/rpi-info.txt
else

	touch /tmp/rpi-info.txt
fi

# timezone timestamp
cat /etc/timezone >> /tmp/rpi-info.txt
echo $infodate >> /tmp/rpi-info.txt

# get RPi model
if [ -e /proc/device-tree/model ]
then
	RPI=$(tr -d '\0' </proc/device-tree/model)
else

	RPI=$(dmesg | grep -i '] DMI:')
	RPI=${RPI:20}

fi
echo $RPI >> /tmp/rpi-info.txt

# get serial number
cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2 >> /tmp/rpi-info.txt

# get git revision
GITREV=`git rev-parse --short HEAD`
echo -e "git revision HEAD id:" $GITREV >> /tmp/rpi-info.txt

# get storage information
 df -h | grep root >> /tmp/rpi-info.txt

# CoCo-Pi version
cat $HOME/cocopi-release.txt >> /tmp/rpi-info.txt

echo
cat /tmp/rpi-info.txt
echo

cd $HOME/.mame


