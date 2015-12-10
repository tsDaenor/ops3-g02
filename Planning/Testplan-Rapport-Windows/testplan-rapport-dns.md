## Testplan en -rapport: installatie dns

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: Tomas Vercautter

### Testplan

Auteur(s) testplan: Dennis Verfaillie

* Identify features to install:  
  `Get-WindowsFeature | Where-Object Name -like *dns*`  

* Install DNS feature  
  `Install-WindowsFeature DNS -IncludeManagementTools –IncludeAllSubFeature`  

* Create A reverse lookup zone
  `Add-DnsServerPrimaryZone –Name 101.168.192.in-addr.arpa –ReplicationScope Forest`     

###### Wanneer je het commando `Get-DnsServerZone` uitvoert dan zie je een lijst met alle aangemaakte zones, zowel de automatische als handmatig aangemaakte.

Al deze commando's zouden moeten slagen zonder problemen. Wanneer je het commando `Get-DnsServerZone` uitvoert zou je ook moeten zien dat er een nieuwe regel 101.168.192.in-addr.arpa bijgekomen is.
  

### Testrapport

Uitvoerder(s) test: Tomas Vercautter

- Alle stappen slagen zonder problemen
- In de lijst met alle zones zie ik de primary zone 101.168.192.in-addr.arpa 
