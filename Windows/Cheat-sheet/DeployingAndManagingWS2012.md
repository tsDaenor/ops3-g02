
# Deploying forest and domain
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
Test the environment to find out whether installing the new forest will succeed.The
[script used](https://github.com/HoGentTIN/ops3-g02/blob/master/Windows/Scripts/DeployingAndManagingWS2012/Test-myForestCreate.ps1 "Script").

#### Deploy the first domain controller and forest
Install the domain and forest. The parameter -SkipPreChecks is used beacause you already tested the environment. The Directory Services Restore Mode (DSRM) is still asked. You can automate this with the `$pwdSS = ConvertTo-SecureString -String 'P@ssw0rd!' -AsPlainText -Force` command. The password is set to 'P@ssw0rd!'.

```Install-ADDSForest `
     -DomainName '<fill in domain name>' `
     -DomainNetBiosName '<fill in bios name>' `
     -DomainMode 6 `
     -ForestMode 6 `
     -NoDnsOnNetwork `
     -SkipPreChecks `
     -Force```

|Parameter			|   Type  		|Description|
|-------------------|---------------|-----------|
|-DomainName		|String			|The fully qualified domain name of the new
domain (TreyResearch.net in this book’s example).|
|[-CreateDnsDelegation]|



#### Check forest and domain installation
Find out what Forest Mode, Domain Mode and Schema Version you've created, use the following [script](https://github.com/HoGentTIN/ops3-g02/blob/master/Windows/Scripts/DeployingAndManagingWS2012/Get-myADVersion.ps1).

#
