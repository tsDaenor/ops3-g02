### Installatie en configuratie DNS

#### Wat doet dit script allemaal?

- Installatie DNS
- Creatie reverse lookup zones
- Creatie primaire zone en statische records

#### Script: sla dit op als dns.ps1

```
Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature
Add-DnsServerPrimaryZone –Name 2.168.192.in-addr.arpa – ReplicationScope Forest
Add-DnsServerPrimaryZone –Name 56.168.192.in-addr.arpa – ReplicationScope Forest
Add-DnsServerPrimaryZone –Name Poliforma.nl –ZoneFile Poliforma.nl.dns
Add-DnsServerResourceRecordA –ZoneName Poliforma.nl –Name www – IPv4Address 192.168.56.11 –CreatePtr
```




    
