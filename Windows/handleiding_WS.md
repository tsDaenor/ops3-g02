##Handleiding Deployment Windows Server 2012 (core)

Deze handleiding stelt u in staat om zelf een Windows 2012 Server via powershell te deployen. Het te bekomen resultaat is net zoals na opdracht 1 en 2 uit de cursus Windows Server

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
     -DefaultGateway 192.168.`
  ``` 
  
  - Set DNS Server
