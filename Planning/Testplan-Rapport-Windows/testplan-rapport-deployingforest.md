## Testplan en -rapport: Deploying Forest

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan: Dennis Verfaillie

- Voer het volgend commando uit om ip-adressen te veranderen
`New-NetIPAddress   -AddressFamily IPv4   -IPAddress 10.10.10.10   -PrefixLength 24   -InterfaceAlias Ethernet`
- Na het uitvoeren van `ip a` krijg je een lijst met IP-addressen, het IPV4Adres zou 10.10.10.10 moeten zijn.  
  
- Voer het commando uit om DNS-adres te veranderen  
`Set-DnsClientServerAddress   -InterfaceAlias Ethernet   -ServerAddresses "10.10.10.10","10.10.10.11"`  
- Na het uitvoeren van de command voor de default route zie je een lijstje met 2 rijen, telkens met destinationprefix 0.0.0.0/0 en ook telkens nexthop 10.10.10.1  

- Na uitvoeren van de commands oms ADDS te installeren:  

  `Get-WindowsFeature | Where-Object Name -like *domain*`    
  `Get-WindowsFeature | Where-Object Name -like *dns*`    
  `Install-WindowsFeature AD-Domain-Services, DNS – IncludeManagementTools`  
  `$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force`  
  `Install-ADDSForest -DomainName corp.contoso.com – SafeModeAdministratorPassword $SMPass –Confirm:$false`

krijg je te zien dat er iets geïnstalleerd wordt. Nadien krijg je een melding dat je afgemeld wordt omdat ADDS geïnstalleerd is. Wanneer je dan volgende keer opnieuw aanmeldt zul je zien dat dit gebeurt via Poliforma\Administrator.


### Testrapport

Uitvoerder(s) test: NAAM

- ...

