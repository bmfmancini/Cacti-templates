this template has been tested on Cisco devices 
this should also work for Nokia and Alcatel devices as well

SNMP will report the following Values 
```
3 - FUll Duplex
2 - Half Duplex
1 - Unknown/Port is down 
```

OID being polled

.1.3.6.1.2.1.10.7.2.1.19 

iso.3.6.1.2.1.10.7.2.1.19.3 = INTEGER: 3 

iso.3.6.1.2.1.10.7.2.1.19.4 = INTEGER: 3 

Installation 

Import 
```
cacti_data_query_interfaceduplex.xml
cacti_data_template_interface-duplex.xml
cacti_graph_template_interface-duplex.xml 
```

via cacti 

Copy duplex.xml to /var/www/html/cacti/resource/snmp_queries


TODO

1, Test THOLD
2, Test AUTOM8
