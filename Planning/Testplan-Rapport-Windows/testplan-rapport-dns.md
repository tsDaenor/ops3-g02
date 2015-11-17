## Testplan en -rapport: installatie dns

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan: Dennis Verfaillie

- Installeer DNS:  
  `Get-WindowsFeature | Where-Object Name -like *dns*`  
  `Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature`  
- Bovenaan het scherm zou een geel kader moeten verschijnen waarin je ziet dat er iets geïnstalleerd wordt.
- Creëer een reverse lookup zone:  
  `Add-DnsServerPrimaryZone –Name 10.10.10.in-addr.arpa – ReplicationScope Forest`  
  `Add-DnsServerPrimaryZone –Name 20.168.192.in-addr.arpa – ReplicationScope Forest`  
- Creëer primaire en statische records:  
  `Add-DnsServerPrimaryZone –Name Poliforma.be –ZoneFile Poliforma.be.dns`
  `Add-DnsServerResourceRecordA –ZoneName Poliforma.be –Name www – IPv4Address 192.168.20.54 –CreatePtr`  
- Voer nu het commando `Get-DnsServerZone` uit. Je zou Poliforma.be 2x moeten zien staan.

  

### Testrapport

Uitvoerder(s) test: NAAM

- ...
