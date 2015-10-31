### Windows Server 2012 Deployment: DHCP manual

##### Configuring DHCP scopes

###### This Manual assumes a server, networking and domain configuration.
###### For this manual you need your computer name, you can check it with the command `Get-Content ENV:Computername` or you can change it by using `Rename-Computer -NewName MyCoreBox -restart`

* Install DHCP and management tools
  - `Get-WindowsFeature | Where-Object Name -like *dhcp*`  
  - `Install-WindowsFeature DHCP -IncludeManagementTools`  
* Create a DHCP scope
  - `Add-DhcpServerv4Scope -Name "Poliformanet" -StartRange 10.10.10.100 -EndRange 10.10.10.200 -SubnetMask 255.255.255.0 `  
* Set DHCP options
  - `Set-DhcpServerv4OptionValue -DnsDomain Poliforma.be -DnsServer 10.10.10.10 -Router 10.10.10.1`  
* Activate DHCP
  - `Add-DhcpServerInDC -DnsName DC1.Poliforma.be`  

