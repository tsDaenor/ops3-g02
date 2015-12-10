### Basisconfiguratie Windows Server 2012 Core

#### Wat wordt er gedaan in dit script?

- Toekennen van IP-adres, default-gateway en dns aan de interfaces
- Computernaam veranderen

##### Zorg er eerst voor dat scripts uitgevoerd kunnen worden op de server

`Set-ExecutionPolicy Bypass`

#### Script: sla dit op als basisconfiguratie.ps1

!!Opgelet: Dit script zal ervoor zorgen dat je server opnieuw opgestart zal worden!!

```
Get-NetAdapter -Name "Ethernet" | Rename-NetAdapter -NewName "InternetConnectie" 
Get-NetAdapter -Name "Ethernet 2" | Rename-NetAdapter -NewName "LanConnectie"
New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.101.11 -PrefixLength 24 -InterfaceAlias "LanConnectie
Set-DnsClientServerAddress -InterfaceAlias "LanConnectie" -ServerAddresses 127.0.0.1
Add-Computer -WorkGroupName PFWERKGROEP 
Rename-Computer -ComputerName PFSV1 -Restart
```
