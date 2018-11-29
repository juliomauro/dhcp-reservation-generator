START TRANSACTION;
SET @ipv4_reservation='172.16.66.116';
SET @hostname = 'Tpl-terraform-centos';
SET @identifier_type='hw-address';
SET @identifier_value='00:50:56:ac:05:9f';
SET @dhcp4_subnet_id=505;
INSERT INTO hosts (dhcp_identifier,
                   dhcp_identifier_type,
                   dhcp4_subnet_id,
                   ipv4_address,
                   hostname,
                   dhcp4_next_server,
                   dhcp4_server_hostname,
                   dhcp4_boot_file_name)
VALUES (UNHEX(REPLACE(@identifier_value, ':', '')),
        (SELECT type FROM host_identifier_type WHERE name=@identifier_type),
        @dhcp4_subnet_id,
        INET_ATON(@ipv4_reservation),
        @hostname,
        INET_ATON(@next_server),
        @server_hostname,
        @boot_file_name);
COMMIT;


