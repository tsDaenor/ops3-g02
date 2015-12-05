### Windows Server 2012 Deployment: DHCP manual

##### Configuring DHCP scopes

###### This Manual assumes a server, networking and domain configuration.
###### For this manual you need your computer name, you can check it with the command `Get-Content ENV:Computername` or you can change it by using `Rename-Computer -NewName DC1 -restart`

* Install DHCP and management tools
  `Get-WindowsFeature | Where-Object Name -like *dhcp*`  
  `Install-WindowsFeature DHCP -IncludeManagementTools`  
  
* Create a DHCP scope
  `Add-DhcpServerv4Scope -Name "Poliformanet" -StartRange 192.168.101.31 -EndRange 192.168.101.130 -SubnetMask 255.255.255.0 `  
* Set DHCP options
  `Set-DhcpServerv4OptionValue -DnsDomain PoliForma.nl -DnsServer 192.168.101.11 -Router 192.168.101.11`  
* Activate DHCP
  `Add-DhcpServerInDC -DnsName PFSV1.PoliForma.nl`  

