
# Deploying forest and domain
### Active Directory Windows PowerShell nouns & commands used (tijdelijk)
#### Nouns
- ADDSDomainController
- ADDSForestInstallation
- ADDSForest
- ADRootDSE
- ADObject
#### Commands
- Get-NetAdapter
- Get-Member
- Set-NetIPAddress
- New-NetIPAddress
- Set-DnsClientServerAddress
- Get-NetIPAddress
- Rename-Computer
- Install-WindowsFeature
- Get-Command
- Format-Table
- Update-Help
- ConvertTo-SecureString

## Deploy forest
### Configure the server IP address
#### Get the adapter alias and index
`Get-NetAdapter`
#
EXTRA: View all the properties and the actions associated with Get-NetAdapter: `Get-NetAdapter | Get-Member`
#### Set a fixed IP Address
1. Disable DHCP: `Set-NetIPInterface -InterfaceAlias "<fill in adapter alias>" -DHCP Disabled -PassThru`. Set-NetIPInterface doesn't return anything but the '-PassThru' parameter returns the status of the IP interface.
2. Set the static IPv4 Address: in the example is the 192.168.10.0/24 subnet used
	
	```New-NetIPAddress `
     -AddressFamily IPv4 `
     -InterfaceAlias "<fill in adapter alias>" ` 
     -IPAddress 192.168.10.2 `
     -PrefixLength 24 `
     -DefaultGateway 192.168.10.1```

3. Set the static IPv6 Address: in the example is the 2001:db8:0:10::/64 subnet used

	```New-NetIPAddress `
     -AddressFamily IPv6 `
     -InterfaceAlias "<fill in adapter alias>" `
     -IPAddress 2001:db8:0:10::2 `
     -PrefixLength 64 `
     -DefaultGateway 2001:db8:0:10::1```

#### Set the DNS server addresses
```Set-DnsClientServerAddress `
     -InterfaceAlias "<fill in adapter alias>" `
     -ServerAddresses <fill in IP addresses separated by ",">```

#### Check IP address configuration
```Get-NetIPAddress -InterfaceAlias "<fill in adapter alias>"```

### Set the server name
Changes the name of the server and restarts it. -Force parameter supresses the confirmation prompt and the -PassThru parameter returns teh results of the command.

```Rename-Computer -NewName <fill in new name> -Restart -Force -Passthru```

### Install Active Directory Domain Services
Installs AD DS, includes the graphical and Windows PowerShell tools to manage and deploy AD

```Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools```

### Create the forest
#### View the cmdlets in ADDSDeployment module
```Get-Command -Module ADDSDeployment | Format-Table Name```

#### Update Windows PowerShell help
It's a good habbit to update the help files if you add modules to a server. This command updates all help files found in $PSModulePath.

```Udate-Help```

Or if your server hasn't access to internet, save it on a networkshare:

1. Save help: `Save-help -DestinationPath <fill in path> -force`
2. Update-help: `Update-Help -DestinatonPath <fill in path> -force`

#### Test the forest creation

