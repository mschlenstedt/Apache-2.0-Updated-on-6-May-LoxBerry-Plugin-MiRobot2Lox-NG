#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
MIIOCLI=$(which miiocli)

# 1 = Debug 2 = Quit
if [[ $5 == "1" ]]; then
	DEBUG="-d"
fi
if [[ $4 == "none" ]]; then
	OPTION=""
else
	OPTION="$4"
fi

# 2 = Quit
if [[ $5 != "2" ]]; then
	echo -e "$MIIOCLI $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION 2>&1\n"
	echo -e "Output:\n"
fi

#$MIIOCLI $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION > /tmp/test.log 2>&1
/usr/local/bin/miiocli $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION 2>&1
