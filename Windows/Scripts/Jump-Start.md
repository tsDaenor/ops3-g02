### Script from PowerShell 3.0 Jump Start

Dit script toont info over een harde schijf.


function get-diskinfo{
[cmdletbinding()]
param(
[Parameter(Mandatory=$true)]
[string[]]$computername}
$bogus
)

get-wmiobject -computername $computername -class win32_logicaldisk -filter "DeviceID='c:'"}


Wanneer je dit opslaat als diskinfo.ps1 dan kun je het uitvoeren met .\diskinfo.ps1 en daarna wordt er een computernaam gevraagd waarvan je de info over de schijf wilt.
