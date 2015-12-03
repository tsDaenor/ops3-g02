## Handleiding Deployment Windows Server 2012 (core): DNS

* Identify features to install:  
  - `Get-WindowsFeature | Where-Object Name -like *dns*`  
* Install DNS feature
  - `Install-WindowsFeature DNS -IncludeManagementTools – IncludeAllSubFeature`  
* Create A reverse lookup zone
  - `Add-DnsServerPrimaryZone –Name 101.168.192.in-addr.arpa – ReplicationScope Forest`   
  - `Add-DnsServerPrimaryZone –Name 20.168.192.in-addr.arpa – ReplicationScope Forest`  
* Create a primary zone and static records
  - `Add-DnsServerPrimaryZone –Name Poliforma.nl –ZoneFile Poliforma.nl.dns`  
  - `Add-DnsServerResourceRecordA –ZoneName Poliforma.nl –Name www – IPv4Address 192.168.20.54 –CreatePtr`  
  

###### Now when you type Get-DnsServerZone, you will see a list of all the DNS zones on the server. You should at least see Poliforma.be 2 times.
