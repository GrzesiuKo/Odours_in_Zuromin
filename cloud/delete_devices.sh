#!/bin/bash

file=$1
NAME=go-vniac
i=0
while IFS= read -r line
do
    DEV=$NAME$i
    sudo ./delete_device.sh $DEV 
    ((i = i + 1))
#done < "$file"
done < <(tail -n +2 "$file")
