# make sure (py)DriveWire is stopped
# make sure Becker port is disabled in MAME

# use 'netcat' command with -bitb socket.localhost:6551 MAME parameters
# i.e. nc -lv localhost 6551

# you can also use 'tail' when creating an output file:
# i.e. tail -f serial-output.txt

# use 'lsof' command (w/grep) to see what file(s), serial ports, etc., may be in use by any processes.
# i.e. lsof | grep ttyUSB2

# use 'stty' command to view or set serial port parameters
# i.e. stty -F /dev/ttyUSB2 -a

# use 'minicom' to test serial ports
# i.e. minicom -b 1200 -o --device /dev/ttyUSB

# use 'tcpser' to enable software based modem emulator
# This one works with MAME and Coco's using a Deluxe RS-232 Pak in an MPI or bitbanger port.  Set CoCo terminal software baud rate,
# MAMEs machine baud rate and tcpser baud rate to same value.
# sample tcpser command line:
# tcpser -i "e1 k0 s0=1" -l 4 -v 6551 -s 2400 -p 6809 -tSs
# sample MAME command line to use with tcpser (above):
# mame coco3h -ramsize 512k -ext multi -ext:multi:slot1 rs232 -ext:multi:slot1:rs232:port null_modem -bitb socket.localhost:6551 -flop1 /media/share1/SDC/COMM/TWITERM.DSK -autoboot_delay 2 -autoboot_command 'LOADM"TWI-TERM.BIN":EXEC\n'

# lookup 'socat' command in Google.  It allows for the creation of virtual serial ports.


# ----- START HERE -----


# example using MPI with Deluxe RS322 Pak with serial traffic being sent to a TCP socket connection on port 6551
#mame coco2 -ext multi -ext:multi:slot1 rs232 -ext:multi:slot1:rs232:port null_modem -bitb socket.localhost:6551 -ui_active -skip_gameinfo

# example using CoCo bitbanger port with serial traffic being sent to a TCP socket connection on port 6551
#mame coco2 -rs232 null_modem -bitb socket.localhost:6551 -flop1 /media/share1/SDC/COMM/GETERM25.DSK -ui_active -skip_gameinfo

# example using CoCo bitbanger port with serial traffic being sent to an output file called 'serial-output.txt'
#mame coco2 -rs232 null_modem -bitb serial-output.txt -ui_active -skip_gameinfo

# example using CoCo bitbanger port with serial traffic being sent to host physical serial port /dev/ttyUSB2 - also mounting GETERM DSK
mame coco2 -rs232 null_modem -bitb /dev/ttyUSB2 -flop1 /media/share1/SDC/COMM/GETERM25.DSK -ui_active -skip_gameinfo

# example using CoCo bitbanger port with serial traffic being sent to a TCP socket connection on port 6551 - also mounting GETERM DSK
#mame coco2 -rs232 null_modem -bitb serial-output.txt -flop1 /media/share1/SDC/COMM/GETERM25.DSK -ui_active -skip_gameinfo
