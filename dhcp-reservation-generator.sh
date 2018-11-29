#!/bin/bash
INPUT=ips.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read macaddress ipaddress user
do
     echo "host $user {"
     echo "next-server $user;"
     echo "hardware ethernet $macaddress;"
     echo "fixed-address $ipaddress;"
     echo "}"
     echo ""
done < $INPUT
IFS=$OLDIFS
