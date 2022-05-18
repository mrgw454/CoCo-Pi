#!/bin/bash

echo "Stopping pyDriveWire server..."
echo ""

cd $HOME/pyDriveWire
./pyDriveWire --stop

#kill $(ps aux | grep 'pyDriveWire' | awk '{print $2}')

rm /tmp/pyDriveWire.pid > /dev/null 2>&1

cd $HOME/.mame

