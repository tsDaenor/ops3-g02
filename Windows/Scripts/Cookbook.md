### All scripts from the book Windows Server 2012 automation with PowerShell cookbook


##### Vermenigvuldig getallen
```
Function Multiply-Numbers {  
Param($FirstNum, $SecNum)  
Try {  
Write-Host ($FirstNum * $SecNum)  
}  
Catch {   
  Write-Host "Error in function, present two numbers to multiply"  
  }   
}  
```

##### Bereken aantal dagen tot kerstmist
```
Function Get-DaysTilChristmas   
{  
$Christmas=Get-Date("25 Dec " + (Get-Date).Year.ToString() + " 7:00 AM")  
$Today = (Get-Date)  
$TimeTilChristmas = $Christmas - $Today  
Write-Host $TimeTilChristmas.Days "Days 'til Christmas"  
}
```

##### update dns records
```
Function Update-DNSServerResourceRecord {  
param(  
[string]$zoneName = $(throw "DNS zone name required")  
,[string]$recordName = $(throw "DNS record name required")  
,[string]$newIPv4Address = $(throw "New IPv4Address required")  
)  
\# Get the current record from DNS  
$oldRecord = Get-DnsServerResourceRecord -ZoneName $zoneName -Name $recordName  
Write-Host "Original Value: " $oldRecord.RecordData. IPv4Address  
\# Clone the record and update the new IP address  
$newRecord=$oldRecord.Clone()  
$newRecord.RecordData.IPv4Address = [ipaddress]$newIPv4Address  
\# Commit the changed record  
Set-DnsServerResourceRecord -ZoneName $zoneName -OldInputObject $oldRecord -NewInputObject $newRecord  
Write-Host "New Value: " (Get-DnsServerResourceRecord -ZoneName $zoneName -Name $recordName).RecordData.IPv4Address  
}
```

##### Create multiple AD user accounts
```
Function Create-Users{  
param($fileName, $emailDomain, $userPass, $numAccounts=10)  
if($fileName -eq $null ){  
[array]$users  = $null  
for($i=0; $i -lt $numAccounts; $i++){  
$users += [PSCustomObject]@{  
FirstName = 'Random'  
LastName = 'User' + $i  
}  
}  
} else  
{   
$users = Import-Csv -Path $fileName   
}
```
