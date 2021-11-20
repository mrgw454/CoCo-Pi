#!/bin/bash

if [ -d logs ]
then

    echo logs folder already present.  Removing any existing log files.
    rm -r -f logs/*.txt
    echo
else
    echo logs folder does not exist.  Creating.
    mkdir logs
    echo
fi


if [ -d compiled ]
then

    echo compiled programs folder already present.  Removing any existing files.
    rm -r -f compiled/*.wav
    rm -r -f compiled/*.c10
    echo
else
    echo compiled programs folder does not exist.  Creating.
    mkdir compiled
    echo
fi


if [ -d batch ]
then

    echo batch folder already present.  Removing any existing batch shell script.
    rm -r -f batch/*.sh
    echo
else
    echo batch folder does not exist.  Creating.
    mkdir batch
    echo
fi


# set processed files counter
COUNTER=1

# create new batch process script for CLOADM
echo \#\!\/bin\/bash > batch/batch-process-mc10-CLOADM.sh
echo echo >> batch/batch-process-mc10-CLOADM.sh
echo clear >> batch/batch-process-mc10-CLOADM.sh
echo echo >> batch/batch-process-mc10-CLOADM.sh

# case insensitive
shopt -s nocaseglob

# JG's programs are provided in TEXT format (*.txt)
for file in *.txt
do

  # set up some variables
  filename=$(basename -- "$file")
  extension="${filename##*.}"
  filename="${filename%.*}"
  workdir=$(pwd)

  echo Compiling $COUNTER - $filename.$extension...

  compile-BASIC-mc10.sh $filename.$extension > logs/$filename-mcbasic-compiler-ouput.txt


  # check if .c10 file exists (after compiling).  If so, make sure it's larger than 283 bytes
  if [[ -f $filename.c10 ]] && [[ $(find $filename.c10 -type f -size +283c 2>/dev/null) ]]; then

    mv $filename.wav compiled
    mv $filename.c10 compiled

    echo echo $COUNTER - $filename.wav >> batch/batch-process-mc10-CLOADM.sh
    echo echo >> batch/batch-process-mc10-CLOADM.sh

    echo echo Make sure to type CLOADM on MC-10 and ... >> batch/batch-process-mc10-CLOADM.sh
    echo read -p \""Press any key to continue... \"" -n1 -s >> batch/batch-process-mc10-CLOADM.sh
    echo echo >> batch/batch-process-mc10-CLOADM.sh

    echo echo Playing $workdir/compiled/$filename.wav ... >> batch/batch-process-mc10-CLOADM.sh
    echo echo >> batch/batch-process-mc10-CLOADM.sh

    echo omxplayer -p -o hdmi $workdir/compiled/$filename.wav >> batch/batch-process-mc10-CLOADM.sh
    echo echo >> batch/batch-process-mc10-CLOADM.sh

    echo echo Now type EXEC on the MC-10. >> batch/batch-process-mc10-CLOADM.sh
    echo read -p \""Press any key to continue... \"" -n1 -s >> batch/batch-process-mc10-CLOADM.sh
    echo echo >> batch/batch-process-mc10-CLOADM.sh
    echo echo >> batch/batch-process-mc10-CLOADM.sh
    echo clear >> batch/batch-process-mc10-CLOADM.sh

  else

    rm $filename.wav
    rm $filename.c10

  fi

  rm $filename.lst
  rm $filename.obj
  rm $filename.asm

  echo -e

  let COUNTER++

done

chmod a+x batch/batch-process-mc10-CLOADM.sh

