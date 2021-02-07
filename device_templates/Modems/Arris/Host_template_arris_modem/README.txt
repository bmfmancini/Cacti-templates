Installation steps for the arris cable modem template.

1. - Copy the arris_cable_modem.php file to <cacti_path>/scripts/ on the server
     that is running cacti.

2. - Goto the Cacti console, login to the interface, click 'Import Templates'.
     The easiest way is to just use 'Import template from local file'.

3. - Now create a new graph/new host. Fill in the description and the IP of
     the modem (usually 192.168.100.1), however this is only for cacti's use, 
     not for the actuall PHP script you have loaded into your scripts folder.
     For 'Host Template' choose 'Arris Modem'. Do not worry about SNMP values
     because the script does not use SNMP.

4. - The Host/Device has been setup, now you just need to create the graphs 
     as normal. 
     
5. - Done!     
     
     *NOTE*
           If the IP of your modem is not 192.168.100.1 then you need to change
           the IP in arris_cable_modem.php.
     *NOTE*