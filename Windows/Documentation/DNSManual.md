## Handleiding Deployment Windows Server 2012 (core): DNS

* Identify features to install:  
  `Get-WindowsFeature | Where-Object Name -like *dns*`  

* Install DNS feature
  `Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature`  

* Create A reverse lookup zone
  `Add-DnsServerPrimaryZone –Name 101.168.192.in-addr.arpa – ReplicationScope Fores`     

###### Wanneer je het commando Get-DnsServerZone uitvoert dan zie je een lijst met alle aangemaakte zones, zowel de automatische als handmatig aangemaakte.
