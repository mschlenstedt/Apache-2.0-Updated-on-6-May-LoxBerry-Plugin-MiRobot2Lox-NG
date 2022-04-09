#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
MIIOCLI=$(which miiocli)
export PYTHONWARNINGS=ignore

# 1 = Debug 2 = Quit
if [[ $6 == "1" ]]; then
        DEBUG="-d"
        echo -e "Dollar1 = $1"
        echo -e "Dollar2 = $2"
        echo -e "Dollar3 = $3"
        echo -e "Dollar4 = $4"
        echo -e "Dollar5 = $5"
        echo -e "Dollar6 = $6"
fi
if [[ $4 == "none" ]]; then
        OPTION=""
else
        OPTION="$4"
fi

#$5 kann nicht leer sein, wird von sendcmd gefuellt
DEVICE=$5
#$3 command
COMMAND=$3

# 2 = Quit
#if [[ $5 != "2" ]]; then
#       echo -e "$MIIOCLI $DEBUG -o json_pretty $DEVICE --ip $1 --token $2 $3 $OPTION 2>&1\n"
#       echo -e "Output:\n"
#fi
#$MIIOCLI $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION > /tmp/test.log 2>&1
#/usr/local/bin/miiocli $DEBUG -o json_pretty vacuum --ip $1 --token $2 $3 $OPTION 2>&1
#FS
if [[ $6 != "2" ]]; then
        if [[ $DEVICE == "roborockvacuum" ]]; then
	        echo -e "$MIIOCLI $DEBUG -o json_pretty $DEVICE --ip $1 --token $2 $3 $OPTION 2>&1\n"
       		echo -e "Output:\n"
        elif [[ $DEVICE == "viomivacuum"  ||  $DEVICE == "dreamevacuum" ]]; then
	        echo -e "$MIIOCLI $DEBUG $DEVICE --ip $1 --token $2 $3 $OPTION 2>&1\n"
	        echo -e "Output:\n"
	fi
fi

if [[ $COMMAND == "dockrelease" ]]; then
        if [[ $DEVICE == "roborockvacuum" ]]; then
                $MIIOCLI $DEBUG $DEVICE --ip $1 --token $2 manual_start2>&1
                sleep 8
		MULT=1000
                TIME="$((OPTION * MULT))"
                OPTIONDR="0 0.27 $TIME"
                $MIIOCLI $DEBUG $DEVICE --ip $1 --token $2 manual_control_once $OPTIONDR 2>&1
        elif [[ $DEVICE == "viomivacuum" ]]; then
                #duration macht Probleme da es wahrscheinlich lokal berechnet wird und die Ausführung der Befehle manchmal länger dauert
                #/usr/local/bin/miiocli $DEBUG $DEVICE --ip $1 --token $2 move forward --duration $OPTION 2>&1
                # nur move forward, reicht für meinen Anwendungsfall aus
                $MIIOCLI $DEBUG $DEVICE --ip $1 --token $2 move forward  2>&1
        fi
        #dockrelease not supported on dreamevaccum
else
        if [[ $DEVICE == "roborockvacuum" ]]; then
                $MIIOCLI $DEBUG -o json_pretty $DEVICE --ip $1 --token $2 $3 $OPTION 2>&1
        elif [[ $DEVICE == "viomivacuum" || $DEVICE == "dreamevacuum" ]]; then
                $MIIOCLI $DEBUG $DEVICE --ip $1 --token $2 $3 $OPTION 2>&1
        fi
fi
