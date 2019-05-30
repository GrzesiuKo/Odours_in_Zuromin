#!/bin/sh

DEV=$1
LAT=$2
LON=$3
H2S=$4
NH3=$5
TEMP=$6
HUMID=$7

#source env/nin/activate

echo "Starting device $DEV"

python ./sensor.py $DEV $LAT $LON $H2S $NH3 $TEMP $HUMID
    

echo "STOPPED device $DEV"
