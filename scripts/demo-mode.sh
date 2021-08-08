#!/bin/bash

# CoCo-Pi multi-emulator demo

# CoCo 2 with YA-DOS and HDD
$HOME/.xroar/coco2us-yados-HD-xroar.sh &

sleep 6

# CoCo 3 with EOU
$HOME/.mame/coco3-hdbdos-6309-nitros9.sh &

sleep 6

# MC-10 with MCX-128 and EMCEE support
$HOME/.mame/mc-10-MCX128-pyDW.sh &

sleep 6

# CoCo 3 using OVCC
$HOME/.ovcc/coco3-decb-demo-OVCC.sh &

# CoCo 2 random carts
$HOME/scripts/attract-mode-random-coco2-xroar.sh /media/share1/carts &
