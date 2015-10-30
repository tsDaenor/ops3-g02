## Handleiding Deployment Windows Server 2012 (core): DNS

* Identify features to install:  
  - `Get-WindowsFeature | Where-Object Name -like *dns*`  

* Install DNS feature
  - `Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature`  
