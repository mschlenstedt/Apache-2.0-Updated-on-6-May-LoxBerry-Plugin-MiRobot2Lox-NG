#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
MIROBOBIN=$(which mirobo)
#echo "mirobo --ip $1 --token $2 $3 $4 $5"
$MIROBOBIN --ip $1 --token $2 $3 $4 $5 2>&1
