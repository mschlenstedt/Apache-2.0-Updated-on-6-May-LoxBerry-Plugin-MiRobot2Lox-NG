#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
#MIROBOBIN=$(which mirobo)
#$MIROBOBIN --ip $1 --token $2 $3 $4 $5 2>&1
MIIOCLI=$(which miiocli)
if [ $5 ]; then
	DEBUG="-d"
fi
if [[ $4 == "none" ]]; then
	OPTION=""
else
	OPTION="$4"
fi
echo -e "$MIIOCLI $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION 2>&1\n"

echo -e "Output:\n"

$MIIOCLI $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION 2>&1
