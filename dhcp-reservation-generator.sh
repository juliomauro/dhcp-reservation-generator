#!/bin/bash
INPUT=ips.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read macaddress ipaddress hostname
do
     echo "host $hostname {"
     echo "next-server $user;"
     echo "hardware ethernet $macaddress;"
     echo "fixed-address $ipaddress;"
     echo "}"
     echo ""
done < $INPUT
IFS=$OLDIFS
