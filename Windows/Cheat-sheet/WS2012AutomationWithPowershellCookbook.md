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

#### 9. Installing and configuring IIS

|  Gebeurtenis | Commando  |
| :---     | :--- |
| install IIS | Get-WindowsFeature | Where-Object Name –likeweb* Install-WindowsFeature Web-WebServer –IncludeManagementTools |
| load webadministration PS module | Import-Module WebAdministration |
| view IIS sites | Get-ChildItem IIS:\sites |

#### 10. Configuring IIS for SSL

|  Gebeurtenis | Commando  |
| :---     | :--- |
| request certificate and install it | Get-Certificate -Template WebServer -DnsName NLB_IIS.corp.contoso. com - CertStoreLocation Cert:\LocalMachine\My |
| create a new https binding | New-WebBinding -Name 'Default Web Site' -Protocol https -Port 443 |
| assign certificate to the binding | $myCert = Get-Item Cert:\LocalMachine\My\\* \| ` Where-Object Subject -eq 'CN=NLB_IIS.corp.contoso.com' $myCert \| New-Item IIS:\SslBindings\0.0.0.0!443 |

#### 11. Configuring a central certificate store

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Configure certificate store | Enable-WebCentralCertProvider -CertStoreLocation \\\corpdc1\certs -UserName'Corp\SSLCerts' -Password 'Pa$$w0rd!' -PrivateKeyPassword 123456 |
| Configure site to use SSL | New-WebBinding -Name 'Default Web Site' -HostHeader Test1.corp. contoso.com -Protocol https -SslFlags 2 |

#### 12. Configuring IIS bindings

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Create a new website using a unique ip address | New-Website -PhysicalPath C:\inetpub\IPBinding -Name IPBinding -IPAddress 10.10.10.250 |
| Create a new website using a unique tcp port | New-Website -PhysicalPath C:\inetpub\PortBinding -Name PortBinding -Port 88 -IPAddress * |
| Create a new website using host headers | New-Website -PhysicalPath C:\inetpub\HostHeader -Name HostHeader -HostHeader HostHeader |
| Change the binding of a website | Set-WebBinding -Name PortBinding -BindingInformation "*:88:" -PropertyName Port -Value 89 |

#### 13. Configuring IIS logging 

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Change IIS logging directory | Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name logFile. directory -Value 'C:\Logs\IIS' |
| Change the logging type | Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name logFile. logFormat 'W3C' |
| Change logging frequency | Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name logFile. period -Value Weekly |
| Change logging to use a maximum size | Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name logFile. period -Value MaxSize Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name logFile. truncateSize 9000000 |
| Disable logging | Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name logFile. enabled -Value False |

#### 14. Configuring NLB across multiple server

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Install NLB feature on the web servers | Invoke-Command -ComputerName web1, web2 ` -ScriptBlock { Install-WindowsFeature NLB -IncludeManagementTools } |
| Set up the NLB clusters on first host | New-NlbCluster -HostName web1 -InterfaceName Ethernet \` -ClusterName NLB_IIS -ClusterPrimaryIP 10.10.10.240 \` -SubnetMask 255.255.255.0 -OperationMode Multicast |
| Add the second host to cluster | Get-NlbCluster -HostName web1|Add-NlbClusterNode -NewNodeName web2 -NewNodeInterface Ethernet |
| Specify the ports for the cluster to balance | Set-NlbClusterPortRule -HostName web1 -NewStartPort 80 -NewEndPort 80 |

#### 15. Monitoring load balancing across NLB nodes

|  Gebeurtenis | Commando  |
| :---     | :--- |
| View the status of the hosts in the cluster | Get-NlbClusterNode -HostName web1 |
| View the cluster's affinity settings | Get-NlbClusterPortRule -HostName web1 |
| View the host connection count for each node | $myNodes = Get-NlbClusterNode -HostName web1 $myCounter = $myNodes.Name \| ForEach-Object {    "\\\$_\\Web Service(_Total)\Current Connections" } Get-Counter -Counter $myCounter |

#### 16. Managing NTFS file permissions

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Read the permissions file and save them into a variable called $ac1 | $acl = Get-Acl M:\Sales\goals.xls |
| Creeate new FileSystemAccessRule | $ace = New-Object System.Security.AccessControl. FileSystemAccessRule "joe.smith","FullControl","Allow" |
| Append the permissions | $acl.SetAccessRule($ace) |
| Apply the permissions to the file | $acl \| Set-Acl M:\Sales\goals.xls |
| Create new folder | New-Item M:\Marketing2 -ItemType Directory |
| Get the existing folder permissions | $SrcAcl = Get-Acl M:\Marketing |
| Set the new permissions | Set-Acl -Path M:\Marketing2 $SrcAcl |
| Take ownership of the folder | $folder = "M:\Groups\Projections" takeown /f $folder /a /r /d Y |
| Add permission for the manager | $acl = Get-Acl $folder $ace = New-Object System.Security.AccessControl. FileSystemAccessRule ` "joe.smith","FullControl","Allow" $acl.SetAccessRule($ace) Set-Acl $folder $acl |
| Recursively overwrite permissions | Get-ChildItem $folder -Recurse -Force |` ForEach {    Get-Acl $acl | Set-Acl -Path $_.FullName } |
| get current permissions | $acl = Get-Acl M:\Groups\Imaging |
| enable or disable inheritance | $acl.SetAccessRuleProtection($True, $False) #first option is to disable inheritance - true=disable \#second option is to keep inherited permissions - false=discard |
| Commit the change | Set-Acl M:\Groups\Imaging $acl |


#### 17. Configuring NTFS deduplication

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Install the deduplication feature on the server | Add-WindowsFeature FS-Data-Deduplication |
| Use DDPEval to report on the estimated savings | ddpeval.exe M:\ |
| Configure the disk for deduplication | Enable-DedupVolume M:\ |
| Set the deduplication age to 0 days to test deduplication process | Set-DedupVolume M: -MinimumFileAgeDays 0 |
| Start the deduplication job | Start-DedupJob M: -type Optimization |


#### 18. Configuring storage pools

|  Gebeurtenis | Commando  |
| :---     | :--- |
| List disks capable of pooling | Get-PhysicalDisk -CanPool $true |
| Using the available disks, create a storage pool | $poolDisks = Get-PhysicalDisk -CanPool $true New-StoragePool -FriendlyName "MyPool" -PhysicalDisks $poolDisks \` -ProvisioningTypeDefault Thin \` -StorageSubSystemFriendlyName "Storage Spaces*" |
| Using the newly created storage pool, create a virtual disk | Get-StoragePool -FriendlyName MyPool \| \` New-VirtualDisk -FriendlyName "TestData" -Size 10GB \` -ProvisioningType Thin |
| Initialize, partition, and format the virtual disk | Get-VirtualDisk -FriendlyName TestData \| Initialize-Disk -PassThru \| \` New-Partition -AssignDriveLetter -UseMaximumSize \| \` Format-Volume -Confirm:$false |


#### 19. Creating and securing CIFS shares

|  Gebeurtenis | Commando  |
| :---     | :--- |
| View current shares on your server | Get-SmbShare |
| Create the first basic file share | New-Item -Path E:\Share1 -ItemType Directory New-SmbShare -Name Share1 -Path E:\share1 |
| Create a second share granting everyone read access | New-Item -Path E:\Share2 -ItemType Directory New-SmbShare -Name Share2 -Path E:\share2 -ReadAccess Everyone ` -FullAccess Administrator -Description "Test share" |
| list share permissions | Get-SmbShare \| Get-SmbShareAccess |
| Grant Full Control access to the first share for user Joe Smith | Grant-SmbShareAccess -Name Share1 -AccountName CORP\Joe.Smith \` -AccessRight Full -Confirm:$false |

#### 20. Accessing CIFS shares from Powershell

|  Gebeurtenis | Commando  |
| :---     | :--- |
| View contents of a share | Get-ChildItem \\\server1\share2  |
| Map the share as persistent | New-PSDrive -Name S -Root \\\server1\share1 -Persist -PSProvider FileSystem |
| Map the share using alternative credentials | $secPass = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText –Force $myCred = New-Object -TypeName PSCredential \` -ArgumentList "CORP\Administrator",$secPass New-PSDrive -Name S -Root \\\server1\share1 -Persist \` -PSProvider FileSystem -Credential $myCred |

#### 21. Creating an NFS export

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Install NFS server service | Add-WindowsFeature FS-NFS-Service –IncludeManagementTools |
| Create a new NFS share | New-Item C:\shares\NFS1 -ItemType Directory  New-NfsShare -Name NFS1 -Path C:\shares\NFS1 |
| Grant access to a remote computer | Grant-NfsSharePermission -Name NFS1 -ClientName Server1 \` -ClientType host -Permission readwrite -AllowRootAccess $true |

#### 22. Installing Windows Server update services

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Install the updateservices feature | Install-WindowsFeature UpdateServices -IncludeManagementTools |
| Perform the initial configuration | New-Item E:\MyContent -ItemType Directory & 'C:\Program Files\Update Services\Tools\WsusUtil.exe' postinstall contentdir=e:\Mycontent |
| Review current synchronization settings | $myWsus = Get-WsuscServer  $myWsus.GetSubscription() |
| Perform the initial synchronization (only syncs categories) | $mySubs = $myWsus.GetSubscription() $mySubs.StartSynchronizationForCategoryOnly() |
| Get a report on the synchronization status | $mySubs.GetSynchronizationProgress()  $mySubs.GetSynchronizationStatus()   $mySubs.GetLastSynchronizationInfo() |






















