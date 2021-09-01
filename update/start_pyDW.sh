rm /tmp/pyDriveWire.pid > /dev/null 2>&1
rm /tmp/pyDriveWire.log > /dev/null 2>&1

cd $HOME/pyDriveWire
./pyDriveWire --daemon

sleep 3s

cd $HOME/.mame

