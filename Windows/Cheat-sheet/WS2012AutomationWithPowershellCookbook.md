## Commands used in the book Windows Server 2012 automation with the PowerShell cookbook

#### 1. Configuring static networking

|  Gebeurtenis | Commando  |
| :---     | :--- |
| find interface | Get-NetIPInterface |
| Set IP information | -AddressFamily IPv4 -IPAddress 10.10.10.10 -PrefixLength 24 -InterfaceAlias Ethernet |
| Set DNS server | Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "10.10.10.10","10.10.10.11" |
| Set default route | New-NetRoute -DesinationPrefix "0.0.0.0/0" -NextHop "10.10.10.1" -InterfaceAlias Ethernet |

#### 2. Installing domain controllers

|  Gebeurtenis | Commando  |
| :---     | :--- |
| zoek features om te installeren | Get-WindowsFeature \| Where-Object Name -Like \*domain\* |
| idem | Get-WindowsFeature \| Where-Object Name -Like \*dns\* |
| installeer de features | Install-WindowsFeature AD-Domain-Services, DNS – IncludeManagementTools |
| configureer domain | $SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force Install-ADDSForest -DomainName Poliforma.be –SafeModeAdministratorPassword $SMPass –Confirm:$false |
| Voeg computer toe aan domain | $secString = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText -Force $myCred = New-Object -TypeName PSCredential -ArgumentList "corp\ administrator", $secString Add-Computer -DomainName "Poliforma.be" -Credential $myCred – NewName "CORPDC2" –Restart |

Het systeem promoveren tot DC

```
Install-WindowsFeature –Name AD-Domain-Services, DNS -IncludeManagementTools –ComputerName CORPDC2 Invoke-Command –ComputerName CORPDC2 –ScriptBlock { $secPass = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText –Force $myCred = New-Object -TypeName PSCredential -ArgumentList "corp\ administrator", $secPass $SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText –Force Install-ADDSDomainController -DomainName corp.contoso.com – SafeModeAdministratorPassword $SMPass -Credential $myCred – Confirm:$false } 
```

#### 3. Configuring zones in DNS

|  Gebeurtenis | Commando  |
| :---     | :--- |
| zoek de te installeren features | Get-WindowsFeature | Where-Object Name -like \*dns\* |
| install dns | Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature |
| create reverse lookup zone | Add-DnsServerPrimaryZone –Name 10.10.10.in-addr.arpa – ReplicationScope Forest Add-DnsServerPrimaryZone –Name 20.168.192.in-addr.arpa –ReplicationScope Forest |
| create primary zone and static records | Add-DnsServerPrimaryZone –Name contoso.com –ZoneFile contoso.com. dns Add-DnsServerResourceRecordA –ZoneName contoso.com –Name www –IPv4Address 192.168.20.54 –CreatePtr |
| create conditional forwarder | Add-DnsServerConditionalForwarderZone -Name fabrikam.com -MasterServers 192.168.99.1  |
| create secondary zone | Add-DnsServerSecondaryZone -Name corp.adatum.com -ZoneFile corp. adatum.com.dns -MasterServers 192.168.1.1 |
| listing all zones | Get-DnsServerZone |

###### zie scripts voor script om dns records up te daten



