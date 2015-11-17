## Testplan en -rapport: installatie dhcp

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan: Dennis Verfaillie

- Verander de computernaam met het commando:  
  `Rename-Computer -NewName DC1 -restart`
- Wanneer de server opnieuw is opgestart kun je de nieuwe naam controleren met:
  `Get-Content ENV:Computername`  

- Installeer DHCP:
  `Get-WindowsFeature | Where-Object Name -like *dhcp*`
  `Install-WindowsFeature DHCP -IncludeManagementTools`
- Creëer een DHCP scope:
  `Add-DhcpServerv4Scope -Name "Poliformanet" -StartRange 10.10.10.100 -EndRange 10.10.10.200 -SubnetMask 255.255.255.0` 
- Configureer opties:
  `Set-DhcpServerv4OptionValue -DnsDomain Poliforma.be -DnsServer 10.10.10.10 -Router 10.10.10.1`  
- Activeer DHCP:
  `Add-DhcpServerInDC -DnsName DC1.Poliforma.be`  

Wanneer dit allemaal geen problemen oplevert, dan is de installatie van DHCP geslaagd.



### Testrapport

Uitvoerder(s) test: NAAM

- ...

