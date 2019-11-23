Basic template to check the HSRP status 
Tested on IOS 12.4

HSRP status are reported by the following values in SNMP

```
1: initial
2: learn
3: listen
4: speak
5: standby
6: active
```

You would make a threshold on your primary router for anything below 6 if for some reason 
the primary goes to standby mode then something is wrong 

Installation instructions 

Import the below files via cacti gui
```
cacti_data_query_hsrp_state.xml
cacti_data_template_hsrp_state.xml
cacti_graph_template_hsrp_state.xml 
```

copy hsrp.xml to /var/www/html/cacti/resource/snmp_queries


Known bugs ?
Not right now but please let me know !


