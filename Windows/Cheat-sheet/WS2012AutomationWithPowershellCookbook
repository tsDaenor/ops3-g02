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
| zoek features om te installeren | Get-WindowsFeature | Where-Object Name -Like \*domain\* |


