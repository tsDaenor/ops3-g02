# Testplan & testrapport - DNS Server:

## Testplan
#### De requirements voor de DNS server zijn:

- De nodige packages moeten geïnstalleerd zijn
  - bind
  - bind-utils
- Het 'dig' commando moet geïnstalleerd zijn
- De main config file moet syntactisch correct zijn 
- De forward zone file moet syntactisch correct zijn 
- De reverse zone file moet syntactisch correct zijn
- De service named moet runnen.
- Forward lookup: 
    - DNS server
    - Database server
    - Monitoring server
    - Webservers
- Reverse lookup:
    - DNS server
    - Database server
    - Monitoring server
    - Webservers



## Testrapport

#### Monitoring server:
De uitvoer van het testscript:
```
 ✓ The necessary packages should be installed
 ✓ The `dig` command should be installed
 ✓ The main config file should be syntactically correct
 ✓ The forward zone file should be syntactically correct
 ✓ The reverse zone files should be syntactically correct
 ✓ The service should be running
 ✓ Forward lookup DNS server
 ✓ Forward lookup Database server
 ✓ Forward lookup Monitoring server
 ✓ Forward lookups Web servers
 ✓ Reverse lookup DNS server
 ✓ Reverse lookup Database server
 ✓ Reverse lookup Monitoring server
 ✓ Reverse lookups Web servers
 ✓ NS record lookup
 
 15 tests, 0 failures
 ```

