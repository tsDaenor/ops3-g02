### Handleiding Deployment Windows Server 2012 (core): Remote Access

* Zoek de te installeren server role  
  `Get-WindowsFeature | Where-Object name -Like *remote*`

* Instaleer remote access  
  `Install-WindowsFeature RemoteAccess -IncludeManagementTools -IncludeAllSubFeature`  


