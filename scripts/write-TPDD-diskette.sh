#./gw read --ecyl 79 --single-sided --rate 125 --revs 1 yourfilenamehere.scp
./gw write yourfilenamehere.scp

# new way

#gw convert "TPDD1 Util.scp" try01.scp --tracks="c=0-39:h=0:step=2"
#gw write --retries=3 --drive=1 --tracks=step=2:c=0-39:h=0 try01.scp
#[3:33 PM]arcadeshopper: with the help of Yann on the fb group
#[3:33 PM]arcadeshopper: ./gw write Util.scp --tracks="c=0-39:h=0:step=2"
