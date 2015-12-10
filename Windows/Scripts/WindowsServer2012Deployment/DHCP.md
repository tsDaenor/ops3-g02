### Installatie en configuratie DHCP

##### Wat wordt er gedaan?

- Installeren DHCP
- Scope configureren
- DHCP activeren

##### Script: sla dit op als dhcp.ps1

```
Get-WindowsFeature | Where-Object Name -like *dhcp*  
Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -Name "PFScopeBudel" -StartRange 192.168.101.31 -EndRange 192.168.101.130 -SubnetMask 255.255.255.0 
Set-DhcpServerv4OptionValue -DnsDomain PoliForma.nl -DnsServer 192.168.101.11 -Router 192.168.101.11
Add-DhcpServerInDC -DnsName PFSV1.PoliForma.nl 
Add-DhcpServerv4Reservation -ScopeId 192.168.101.0 -IPAddress 192.168.101.80 -ClientId (mac-adres NIC) -Description "Reservation for host"
```
