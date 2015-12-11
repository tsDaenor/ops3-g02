# Change power saving settings
- Change the monitor time out to 0: `powercfg.exe -change -monitor-timeout-ac 0`
- Change the standy time out to 0: `powercfg.exe -change -standby-timeout-ac 0`

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
 You can see the parameters by using `get-help Set-DnsServerprimaryZone`.
 For example:
 ```
 Set-DnsServerPrimaryZone -Name 'TailspinToys.com' 
                         -Notify 'NotifyServers' 
                         -NotifyServers "192.168.10.201","192.168.10.202" 
                         -PassThru
```

#### Export a primary zone
You can easily export a primary zone with the `Export-DnsServerZone`command.
An example to export an IPv6 reverse lookup zone:
```
Export-DnsServerZone -Name '0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa' 
                     -Filename '0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.dns'
```

### Manage secondary zones

#### Create secondary zones
The `Add-DnsServerSecondaryZone`is used to create secondary zones.
For example:
```
Add-DnsServerSecondaryZone –Name 0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa `
                           -ZoneFile "0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.dns" `
                           -LoadExisting `
                           -MasterServers 192.168.10.2,2001:db8:0:10::2 `
                           -PassThru
```

#### Change the settings of a secondary zone
Secondary zones have few settings because they are read-only zones dependent on their master servers. But if you need to change the master server for example, it is possible.
For example:
```
Set-DnsServerSecondaryZone -Name 0.1.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa 
                           -MasterServers 192.168.10.3,2001:db8:0:10::3 
                           -PassThru
```
NOTE: you can also use the 'NetworkID' parameter instead of the 'Name' parameter.

#### Configure zone transfer settings
A secondary zone can only transfer the zone from a primary zone that allows the transfer. The setting of a zone transfer permissions is done at the primary zone. To set the zone transfer permissions, use the `Set-DnsServerprimaryZone`command.
For example:
```
Set-DnsServerPrimaryZone -Name 'treyresearch.net' `
                         -SecureSecondaries TransferToZoneNameServer `
                         -PassThru
```
The 'SecureSecondaries' parameter accepts the following values:

 Value   |  Meaning	
----------------------|----------------------------------------------------------------------------
NoTransfer| No transfers are allowed for this zone from the server.
TransferAnyServer| Any server can request a zone transfer, including servers that you know nothing about and don't manage or control.
TransferToZoneNameServer | Only servers in the NS records for this zone are allowed to request transfers.
TransferToSecureServers | Only servers specified with the '-SecondaryServers' parameter are allowed to request a zone transfer.

### Manage stub zones
Stub DNS zones contain the necessary records to locate a zone's name server *only*. they do not maintain the records of other computers or devices in the zone.
The `DnsServerStubZone`command is used to deploy and manage stub zones. 
An example to add an new stub zone for TailSpinToys.com, whose master is 192.168.10.4:
```
Add-DnsServerStubZone -Name TailspinToys.com `
                      -MasterServers 192.168.10.4 `
                      -ReplicationScope Domain `
                      -PassThru
```
To change the properties of the DNS stub zone to use a local array of master servers use the following:
```
Add-DnsServerStubZone -Name TailspinToys.com `
                      -MasterServers 192.168.10.4 `
                      -ReplicationScope Domain `
                      -PassThru
```

### Configure conditional forwards

Use conditional forwards to specify where to forward DNS request for a specific DNs domain. When you have multiple internal DNS domains, you might need to resolve DNS names from another internal domain. You could maintain a stub zone for that domain, but you can also use conditional forwards. For example if your DNS domain is TailSpinToys.com and you want to set a conditional forward for treyresearch.net:
```
Add-DnsServerConditionalForwarderZone -Name treyresearch.net `
                                      -MasterServers 192.168.10.2,2001:db8::10:2 `
                                      -ForwarderTimeout 5 `
                                      -ReplicationScope "Forest" `
                                      -Recursion $False `
                                      -PassThru
```

| Parameter | meaning |
| --- | --- |
| ForwarderTimeOut | If a server hasn't answered in 5 seconds, the next server is queried. |
| Recursion | If this parameter is specified false and if none of the master servers specified answers the resuest, the DNS lookup fails. |

#### Change settings of an existing DNS conditional forward

Use the `Set-DnsServerConditionalForwarderZone`command. For example, to change the conditional forward for TreyResearch.net to specify new master servers:
```
Add-DnsServerConditionalForwarderZone -Name treyresearch.net `
                                      -MasterServers 192.168.10.3,2001:db8::10:3 `
                                      -PassThru
```
Conditional forwards are stored as zones. 

#### Remove a conditional forward

Use the `Remove-DnsServerZone`command.

### Manage zone delegation
With this you can divide a large zone into smaller subzones to distribute the load an improve performance.
You can for example delegate a subzone to a different DNS server to distribute the load and administrative overhead. For example, you can add a delegation to a subzone to a server:
```
Add-DnsServerZoneDelegation -Name TreyResearch.net `
                            -ChildZoneName Engineering `
                            -IPAddress 192.168.10.12,2001:db8::c `
                            -NameServer trey-engdc-12.engineering.treyresearch.net `
                            -PassThru
```
The 'DnsServerZoneDelegation' group of commands includes the verbs Add, Get, remove and Set. Use the `Set-DnsServerZoneDelegation`command to change the IP address or addresses to which to delegate the zone. This doesn't add them but replaces them. For example:
```
Set-DnsServerZoneDelegation `
             -Name TreyResearch.net `
             -ChildZoneName Engineering `
             -IPAddress 192.168.10.13,2001:db8::d `
             -NameServer trey-engdc-13.engineering.treyresearch.net `
             -PassThru
```

## Manage DNS records
DNS servers also provide information that other services and servers need to know which server hosts a particular service.
each of these services is designated by a specific type of DNS record.
Windows DNS supports a wide variety of DNS records.

|Command | Description |
| --- | --- 
| ```Get-Help Add-DnsServerResourceRecord* | ft -auto Name,Synopsis``` | Gives all the the possible Add-DnsResourceRecord cmdlets |
| `Add-DnsServerResourceRecord  -ZoneName "TreyResearch.net" -A  -Name trey-wds-11 -IPv4Address 192.168.10.11  -CreatePtr  -PassThru `| Example: adding a A record |
|


