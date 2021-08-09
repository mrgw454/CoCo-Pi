clear

MAMEPARMSFILE=`cat $HOME/.mame/.optional_mame_parameters.txt`
export MAMEPARMS=$MAMEPARMSFILE

cp $HOME/.mame/cfg/coco3h.cfg.beckerport-enabled $HOME/.mame/cfg/coco3h.cfg

mame coco3h -ramsize 512k -ext multi -ext:multi:slot4 fdcv11 -cart5 /media/share1/roms/hdbdw3bc3.rom $MAMEPARMS

# capture MAME ERRORLEVEL

if [ $? -eq 0 ]
then
        echo
else
        echo
        echo "Please make note of message above when requesting help."
        echo
        read -p  "Press any key to continue." -n1 -s
fi

cp $HOME/.mame/cfg/coco3h.cfg.beckerport-disabled $HOME/.mame/cfg/coco3h.cfg

cd $HOME/.mame
CoCoPi-menu-Coco3.sh
