### Basisconfiguratie Windows Server 2012 Core

#### Wat wordt er gedaan in dit script?

- Toekennen van IP-adres, default-gateway en dns aan de interfaces
- Computernaam veranderen

##### Zorg er eerst voor dat scripts uitgevoerd kunnen worden op de server

`Set-ExecutionPolicy Bypass`

#### Script: sla dit op als basisconfiguratie.ps1

!!Opgelet: Dit script zal ervoor zorgen dat je server opnieuw opgestart zal worden!!

```
New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.2.111 -PrefixLength 24 -InterfaceAlias Ethernet
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "192.168.2.254"
New-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop "192.168.2.254" -InterfaceAlias Ethernet

New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.56.11 -PrefixLength 24 -InterfaceAlias "Ethernet 2"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "127.0.0.1"

Rename-Computer -NewName PFSV1 -restart
```
