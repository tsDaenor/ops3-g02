### Windows server 2012 core: Network Printer Manual

* Zoek de te installeren features  
`Get-WindowsFeature | Where-Object Name -like *print*`  
`Install-WindowsFeature Print-services -IncludeManagementTools`

* Voeg een nieuwe printerdriver toe  
`Add-PrinterDriver -ComputerName PFSV1 -Name "HP LaserJet 5200 PS Class Driver"`

* Voeg een nieuwe printerpoort toe  
`Add-PrinterPort -ComputerName PFSV1 -Name PFPR1Port -PrinterHostAddress 192.168.101.131`

* Voeg de printer toe  
`Add-Printer -ComputerName PFSV1 -Name PFPR1 -DriverName "HP LaserJet 5200 PS Class Driver" -Shared -ShareName PFPR1 -PortName PFPR1Port`

* Pas instellingen van de printer aan  
`Set-PrintConfiguration -ComputerName PFSV1 -PrinterName "PFPR1" -PaperSize Legal`
