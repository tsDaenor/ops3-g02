##Handleiding Deployment Windows Server 2012 (core): Deploy Forest

Deze handleiding stelt u in staat om je eerste forest te deployen op Windows Server 2012 (core) met behulp van commando's in powershell.

#####Deploy your first forest
* Ga naar Powershell:
  `powershell`  
* Find the interface
  - `Get-NetIPInterface`  
  
* Configure the server ip address
  - Set IPv4 Address  
   `New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.101.11 -PrefixLength 24 -InterfaceAlias "Ethernet 2"`
   `New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.2.111 -PrefixLength 24 -InterfaceAlias Ethernet`
  
  - Set DNS Server addresses
  ```
  Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses 127.0.0.1
  Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 192.168.2.254
  ```
  
* Set default route
  - `New-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop "192.168.2.254" -InterfaceAlias Ethernet` 
  
* Install ADDS
  - `Get-WindowsFeature | Where-Object Name -like *domain*`  
  - `Get-WindowsFeature | Where-Object Name -like *dns*`  
  - `Install-WindowsFeature AD-Domain-Services, DNS –IncludeManagementTools`  
  - `$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force`  
  - `Install-ADDSForest -DomainName Poliforma.nl –SafeModeAdministratorPassword $SMPass –Confirm:$false`

