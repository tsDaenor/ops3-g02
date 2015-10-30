### Windows Server 2012 Deployment: DHCP manual

##### Configuring DHCP scopes

######This Manual assumes a server, networking and domain configuration.

* Install DHCP and management tools
  - `Get-WindowsFeature | Where-Object Name -like *dhcp*`  
  - `Install-WindowsFeature DHCP -IncludeManagementTools`  

