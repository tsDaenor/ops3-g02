##Handleiding Deployment Windows Server 2012 (core): Deploy Forest

Deze handleiding stelt u in staat om je eerste forest te deployen op Windows Server 2012 (core) met behulp van commando's in powershell.

#####Deploy your first forest
* Configure the server ip address
  - disable DHCP on Ethernet 2 adapter
   `Set-NetIPInterface -InterfaceAlias "Ethernet 2" -DHCP Disabled -PassThru`
  
  - Set IPv4 Address to 192.168.10.2
  ```
  New-NetIPAddress `
     -AddressFamily IPv4 `
     -InterfaceAlias "10 Network" `
     -IPAddress 192.168.10.2 `
     -PrefixLength 24 `
     -DefaultGateway 192.168.10.1`
  ``` 
  
  - Set IPv6 Address to 2001:db8:0:10::2
   ```
  New-NetIPAddress `
     -AddressFamily IPv6 `
     -InterfaceAlias "10 Network" `
     -IPAddress 2001:db8:0:10::2 `
     -PrefixLength 64 `
     -DefaultGateway 2001:db8:0:10::1`
  ``` 
  
  - Set DNS Server addresses
  ```
  Set-DnsClientServerAddress `
     -InterfaceAlias "10 Network" `
     -ServerAddresses 192.168.10.2,2001:db8:0:10::2
  ```
  
  - Set the server name
  `Rename-Computer -NewName PFSV1 -Restart -Force -PassThru`

  - Install Active Directory Domain Services
  `Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools`
