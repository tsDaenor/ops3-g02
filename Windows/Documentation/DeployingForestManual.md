##Handleiding Deployment Windows Server 2012 (core): Deploy Forest

Deze handleiding stelt u in staat om je eerste forest te deployen op Windows Server 2012 (core) met behulp van commando's in powershell.

#####Deploy your first forest
* Ga naar Powershell:
  `powershell`  

* Vind de verschillende interfaces
  `Get-NetIPInterface`  

* Verander de interfaces van naam
  `Get-NetAdapter -Name "Ethernet" | Rename-NetAdapter -NewName "InternetConnectie"`  
  `Get-NetAdapter -Name "Ethernet 2" | Rename-NetAdapter -NewName "LanConnectie"` 

* Verander de computernaam naar PFSV1  
  `Rename-Computer -ComputerName PFSV1`

* Maak de werkgroep PFWERKGROEP aan en join deze werkgroep
  `Add-Computer -WorkGroupName PFWERKGROEP -Restart` 
  
* Configure the server ip address
  - Set IPv4 Address  
    `New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.101.11 -PrefixLength 24 -InterfaceAlias "LanConnectie"`
  
  - Set DNS Server addresses
    `Set-DnsClientServerAddress -InterfaceAlias "LanConnectie" -ServerAddresses 127.0.0.1`
  
* Install ADDS
  - `Get-WindowsFeature | Where-Object Name -like *domain*`  
  - `Get-WindowsFeature | Where-Object Name -like *dns*`  
  - `Install-WindowsFeature AD-Domain-Services, DNS –IncludeManagementTools`  
  - `$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force`  
  - `Install-ADDSForest -DomainName PoliForma.nl –SafeModeAdministratorPassword $SMPass –Confirm:$false`
  
Wanneer je na het heropstarten je moet aanmelden zul je zien dat er bij gebruikersnaam nu staat 'POLIFORMA\Administrator'. Dit wil zeggen dat het domein succesvol aangemaakt werd.

