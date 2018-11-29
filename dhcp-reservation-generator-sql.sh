#!/bin/bash
INPUT=ips.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read macaddress ipaddress hostname
do
     echo "START TRANSACTION;" 
     echo "SET @ipv4_reservation='$ipaddress';" 
     echo "SET @hostname = '$hostname';" 
     echo "SET @identifier_type='hw-address';" 
     echo "SET @identifier_value='$macaddress';" 
     echo "SET @dhcp4_subnet_id=505;" 
     echo "INSERT INTO hosts (dhcp_identifier," 
     echo "                   dhcp_identifier_type," 
     echo "                   dhcp4_subnet_id," 
     echo "                   ipv4_address," 
     echo "                   hostname," 
     echo "                   dhcp4_next_server," 
     echo "                   dhcp4_server_hostname," 
     echo "                   dhcp4_boot_file_name)" 
     echo "VALUES (UNHEX(REPLACE(@identifier_value, ':', ''))," 
     echo "        (SELECT type FROM host_identifier_type WHERE name=@identifier_type)," 
     echo "        @dhcp4_subnet_id," 
     echo "        INET_ATON(@ipv4_reservation)," 
     echo "        @hostname," 
     echo "        INET_ATON(@next_server)," 
     echo "        @server_hostname," 
     echo "        @boot_file_name);" 
     echo "COMMIT;" 
     echo ""
     echo ""

done < $INPUT
IFS=$OLDIFS
