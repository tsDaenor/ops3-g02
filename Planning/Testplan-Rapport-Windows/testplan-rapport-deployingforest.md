## Testplan en -rapport: Deploying Forest

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: Toon Lamberigts

### Testplan

Auteur(s) testplan: Dennis Verfaillie

* Verander de interfaces van naam
  `Get-NetAdapter -Name "Ethernet" | Rename-NetAdapter -NewName "InternetConnectie"`  
  `Get-NetAdapter -Name "Ethernet 2" | Rename-NetAdapter -NewName "LanConnectie"` 

* Verander de computernaam naar PFSV1  
  `Rename-Computer -ComputerName PFSV1`

* Maak de werkgroep PFWERKGROEP aan en join deze werkgroep
  `Add-Computer -WorkGroupName PFWERKGROEP -Restart` 
  
* Configure the server ip address
  - Set IPv4 Address  
    `New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.101.11 -PrefixLength 24 -InterfaceAlias "LanConnectie"`
  
  - Set DNS Server addresses
    `Set-DnsClientServerAddress -InterfaceAlias "LanConnectie" -ServerAddresses 127.0.0.1`
  
* Install ADDS
  - `Get-WindowsFeature | Where-Object Name -like *domain*`  
  - `Get-WindowsFeature | Where-Object Name -like *dns*`  
  - `Install-WindowsFeature AD-Domain-Services, DNS –IncludeManagementTools`  
  - `$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force`  
  - `Install-ADDSForest -DomainName PoliForma.nl –SafeModeAdministratorPassword $SMPass –Confirm:$false`

Na het uitvoeren van al deze stappen en herstarten van de computer moet je enkele dingen merken
- Na het heropstarten kun je je aanmelden als Poliforma\Administrator
- Als je het commando `ipconfig /all` uitvoert dan zie je dat je server nu in het domein PoliForma.nl zit.
- Ook zie je nu een adapter LanConnectie en InternetConnectie. LanConnectie zou 192.168.101.11 als ip-adres moeten hebben


### Testrapport

Uitvoerder(s) test: Toon Lamberigts

- Al deze stappen uitvoeren lukte zonder problemen
- Na het heropstarten zie ik dat me kan aanmelden als Poliforma\Administrator
- Ik zit effectief in het domein PoliForma.nl
- Ethernet en Ethernet 2 zijn inderdaad van naam veranderd. Ook de ip-adressen staan zoals we het willen

