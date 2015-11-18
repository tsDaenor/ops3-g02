### Installatie en configuratie DHCP

##### Wat wordt er gedaan?

- Installeren DHCP
- Scope configureren
- DHCP activeren

##### Script: sla dit op als dhcp.ps1

```
Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -Name "Poliformanet" -StartRange 192.168.56.31 -EndRange 192.168.56.130 -SubnetMask 255.255.255.0
Set-DhcpServerv4OptionValue -DnsDomain Poliforma.be -DnsServer 192.168.56.11 -Router 192.168.56.11
Add-DhcpServerInDC -DnsName PFSV1.Poliforma.nl
```
