#!/bin/bash

file=$1
i=0
while IFS= read -r line
do
    IFS=':' read -ra ADDR <<< "$line"
    
    DEV=go-vniac$i
    ((i = i + 1))
    #DEV=${ADDR[0]}
    LAT=${ADDR[0]}
    LON=${ADDR[1]}
    H2S=${ADDR[2]}
    NH3=${ADDR[3]}
    TEMP=${ADDR[4]}
    HUMID=${ADDR[5]}

    sudo ./start_device.sh $DEV $LAT $LON $H2S $NH3 $TEMP $HUMID &

done < <(tail -n +2 "$file")
