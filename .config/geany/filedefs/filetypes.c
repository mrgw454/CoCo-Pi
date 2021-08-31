[build-menu]
EX_00_LB=_Renumber BASIC program
EX_00_CM=/home/pi/scripts/renumBASIC.sh %f %f 10
EX_00_WD=%d
EX_01_LB=Build Coco 2 DSK image and launch MAME (local)
EX_01_CM=/home/pi/scripts/makeDSK.sh coco2 n
EX_01_WD=%d
EX_02_LB=Build Coco 2 DSK image and launch MAME (pyDW)
EX_02_CM=/home/pi/scripts/makeDSK.sh coco2 y
EX_02_WD=%d
EX_03_LB=Build Coco 2 DSK image and launch XRoar (local)
EX_03_CM=/home/pi/scripts/makeDSK-XRoar.sh coco2bus n
EX_03_WD=%d
EX_04_LB=Build Coco 2 DSK image and launch XRoar (pyDW)
EX_04_CM=/home/pi/scripts/makeDSK-XRoar.sh coco2bus y
EX_04_WD=%d
EX_05_LB=Build Coco 3 DSK image and launch MAME (local)
EX_05_CM=/home/pi/scripts/makeDSK.sh coco3 n
EX_05_WD=%d
EX_06_LB=Build Coco 3 DSK image and launch MAME (pyDW)
EX_06_CM=/home/pi/scripts/makeDSK.sh coco3dw1 y
EX_06_WD=%d
EX_07_LB=Compile assembly program (lwasm)
EX_07_CM=/usr/bin/lwasm --6809 --decb --output=%d/%e.bin %d/%f
EX_07_WD=%d
EX_08_LB=Compile assembly program (asm6809)
EX_08_CM=/usr/bin/asm6809 --coco --output=%d/%e.bin %d/%f
EX_08_WD=%d
EX_09_LB=Compile C program (CMOC)
EX_09_CM=/usr/bin/cmoc -o %d/%e.bin %d/%f
EX_09_WD=%d
