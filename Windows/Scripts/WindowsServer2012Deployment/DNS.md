### Installatie en configuratie DNS

#### Wat doet dit script allemaal?

- Installatie DNS
- Creatie primaire zone

#### Script: sla dit op als dns.ps1

```
Get-WindowsFeature | Where-Object Name -like *dns* 
Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature
Add-DnsServerPrimaryZone –Name 101.168.192.in-addr.arpa –ReplicationScope Forest
```




    
