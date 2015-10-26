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
Install-WindowsFeature –Name AD-Domain-Services, DNS -IncludeManagementTools –ComputerName CORPDC2 Invoke-Command  
–ComputerName CORPDC2 –ScriptBlock { $secPass = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText –Force $myCred = New-Object  
-TypeName PSCredential -ArgumentList "corp\ administrator", $secPass $SMPass = ConvertTo-SecureString 'P@$$w0rd11'  
–AsPlainText –Force Install-ADDSDomainController -DomainName corp.contoso.com – SafeModeAdministratorPassword $SMPass  
-Credential $myCred – Confirm:$false }  
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

#### 4. Configuring DHCP scopes

|  Gebeurtenis | Commando  |
| :---     | :--- |
| install dhcp and management tools | Get-WindowsFeature | Where-Object Name -like \*dhcp\* Install-WindowsFeature DHCP -IncludeManagementTools |
| create dhcp scope | Add-DhcpServerv4Scope -Name "Corpnet" -StartRange 10.10.10.100 -EndRange 10.10.10.200 -SubnetMask 255.255.255.0 |
| set dhcp options | Set-DhcpServerv4OptionValue -DnsDomain corp.contoso.com -DnsServer 10.10.10.10 -Router 10.10.10.1  |
| activate dhcp | Add-DhcpServerInDC -DnsName corpdc1.corp.contoso.com |
| adding dhcp reservation | Add-dhcpserverv4reservation –scopeid 10.10.10.0 –ipaddress 10.10.10.102 –name test2 –description "Test server" –clientid 1234-56-78-90-12 Get-dhcpserverv4reservation –scopeid 10.10.10.0 |
| adding dhcp exclusions | Add-DhcpServerv4ExclusionRange –ScopeId 10.10.10.0 –StartRange 10.10.10.110 –EndRange 10.10.10.111 Get-DhcpServerv4ExclusionRange |

#### 5. Building out a PKI environment

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Install certificate server | Get-WindowsFeature | Where-Object Name -Like *cert* Install-WindowsFeature AD-Certificate -IncludeManagementTools -IncludeAllSubFeature |
| Configure server as an enterprise CA | Install-AdcsCertificationAuthority -CACommonName corp.contoso.com -CAType EnterpriseRootCA -Confirm:$false |
| install root certificate | Certutil –pulse |
| request machine certificate | Set-CertificateAutoEnrollmentPolicy -PolicyState Enabled -Context Machine -EnableTemplateCheck |

#### 6. Creating AD users

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Create a single AD user account | New-ADUser -Name JSmith |
| Create multiple AD user accounts | zie scripts |

#### 7. Searching for and reporting on AD users

|  Gebeurtenis | Commando  |
| :---     | :--- |
| report on all users and their logon scripts | Get-ADUser -Filter * -Properties SamAccountName, DisplayName, \` ProfilePath, ScriptPath \| \` Select-Object SamAccountName, DisplayName, ProfilePath, ScriptPath |
| find all disabled user accounts | Get-ADUser –Filter 'Enabled -eq $false' |
| find users that haven't logged in in the last 30 days | $logonDate = (Get-Date).AddDays(-30) Get-ADUser -Filter 'LastLogonDate -lt $logonDate' \| Select-Object DistinguishedName |
| find accounts with multiple logon failures | $primaryDC = Get-ADDomainController -Discover -Service PrimaryDC Get-ADUser -Filter 'badpwdcount -ge 5' -Server $primaryDC.Name ` -Properties BadPwdCount \| Select-Object DistinguishedName, BadPwdCount
|

#### 8. Finding expired computers in AD

|  Gebeurtenis | Commando  |
| :---     | :--- |
| find recently aged accounts | $30Days = (Get-Date).AddDays(-30) Get-ADComputer -Properties lastLogonDate -Filter 'lastLogonDate -lt $30Days' \| Format-Table Name, LastLogonDate |
| find older accounts | $60Days = (Get-Date).AddDays(-60) Get-ADComputer -Properties lastLogonDate -Filter 'lastLogonDate -lt $60Days' \| Format-Table Name, LastLogonDate |






