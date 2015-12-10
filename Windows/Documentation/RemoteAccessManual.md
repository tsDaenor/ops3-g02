### Handleiding Deployment Windows Server 2012 (core): Remote Access

* Zoek de te installeren server role  
  `Get-WindowsFeature | Where-Object name -Like *remote*`

* Instaleer remote access  
  `Install-WindowsFeature RemoteAccess -IncludeManagementTools -IncludeAllSubFeature`  

* Voeg een rules toe aan de firewall zodat een verbinding mogelijk is.

  ```Enable-NetFirewallRule -DisplayGroup "Remote Desktop"```


