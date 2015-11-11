# Change power saving settings
- Change the monitor time out to 0: `powercfg.exe -change -monitor-timeout-ac 0`.
- Change the standy time out to 0: `powercfg.exe -change -standy-timeout-ac 0`.

# Deploying forest and domain
### Configure the server IP address
#### Get the adapter alias and index
`Get-NetAdapter`
#
View all the properties and the actions associated with Get-NetAdapter: `Get-NetAdapter | Get-Member`
#### Set a fixed IP Address
1. Disable DHCP: `Set-NetIPInterface -InterfaceAlias "<fill in adapter alias>" -DHCP Disabled -PassThru`. Set-NetIPInterface doesn't return anything but the '-PassThru' parameter returns the status of the IP interface.
2. Set the static IPv4 Address: in the example is the 192.168.10.0/24 subnet used
	
	```
     New-NetIPAddress 
     -AddressFamily IPv4 
     -InterfaceAlias "<fill in adapter alias>" 
     -IPAddress 192.168.10.2 
     -PrefixLength 24 
     -DefaultGateway 192.168.10.1
     ```

3. Set the static IPv6 Address: in the example is the 2001:db8:0:10::/64 subnet used

	```
      New-NetIPAddress 
     -AddressFamily IPv6 
     -InterfaceAlias "<fill in adapter alias>" 
     -IPAddress 2001:db8:0:10::2 
     -PrefixLength 64 
     -DefaultGateway 2001:db8:0:10::1
     ```

#### Set the DNS server addresses
```
Set-DnsClientServerAddress 
-InterfaceAlias "<fill in adapter alias>" 
-ServerAddresses <fill in IP addresses separated by ",">
```

#### Check IP address configuration
```
Get-NetIPAddress -InterfaceAlias "<fill in adapter alias>"
```

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

```
Udate-Help
```

Or if your server hasn't access to internet, save it on a networkshare:

1. Save help: `Save-help -DestinationPath <fill in path> -force`
2. Update-help: `Update-Help -DestinatonPath <fill in path> -force`

#### Test the forest creation
Test the environment to find out whether installing the new forest will succeed.The
[script used](https://github.com/HoGentTIN/ops3-g02/blob/master/Windows/Scripts/DeployingAndManagingWS2012/Test-myForestCreate.ps1 "Script").

#### Deploy the first domain controller and forest
Install the domain and forest. The parameter -SkipPreChecks is used beacause you already tested the environment. The Directory Services Restore Mode (DSRM) is still asked. You can automate this with the `$pwdSS = ConvertTo-SecureString -String 'P@ssw0rd!' -AsPlainText -Force` command. The password is set to 'P@ssw0rd!'.

	```
     Install-ADDSForest 
     -DomainName '<fill in domain name>' 
     -DomainNetBiosName '<fill in bios name>' 
     -DomainMode 6 
     -ForestMode 6 
     -NoDnsOnNetwork 
     -SkipPreChecks 
     -Force
     ```


#### Check forest and domain installation
Find out what Forest Mode, Domain Mode and Schema Version you've created, use the following [script](https://github.com/HoGentTIN/ops3-g02/blob/master/Windows/Scripts/DeployingAndManagingWS2012/Get-myADVersion.ps1).

# Manage DNS and DHCP
## Manage DNS zones
### Manage primary zones
#### Create new primary zones
This creates an Active Directory-integrated zone that is replicated to the domain only. It accepts secure dynamic updates.
A reverse lookup zone is not automaticly created.
```
Add-DnsServerPrimaryZone -Name '<fill in a name>' 
                         -ComputerName '<fill in full computer name, like: name.domainname.com>' 
                         -ReplicationScope 'Domain' 
                         -DynamicUpdate 'Secure' 
                         -PassThru
```
##### Create a reverse lookup zone
It is similar to creating a forward lookup zone. Instead of the 'Name' parameter, you use the 'NetworkID' parameter.
It is replicated accross the entire forest and accepts both secure and nonsecure updates.
The 'NetworkID' parameter can also be an IPv6 address to create an IPv6 reverse lookup zone
```
Add-DnsServerPrimaryZone -NetworkID 192.168.10.0/24 
                         -ReplicationScope 'Forest' 
                         -DynamicUpdate 'NonsecureAndSecure' 
                         -PassThru
```
NOTE: adjust the parameters to your own situation.

##### Create a file-based zone
Just use the 'ZoneFile' parameter, for example:
```
Add-DnsServerPrimaryZone -Name 'tailspintoys.com' `
                         -ZoneFile 'tailspintoys.com.dns' `
                         -DynamicUpdate 'None'
 ```
 
#### Change the settings of a primary zone
 To change the settings you use the 'Set-DnsServerPrimaryZone' command.
