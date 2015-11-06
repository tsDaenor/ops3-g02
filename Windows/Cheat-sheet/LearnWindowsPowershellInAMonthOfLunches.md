## Commands used in the book "Learn Windows Powershell In A Month Of Lunches"

#### Chapter 2: Running commands

##### 2.7 The same old commands - almost.

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Display a list of services | Get-Service |
| Display a list of running processes | Get-Process |
| Display the contents of an event log | Get-EventLog |
| Create a new service | New-Service |


#### Chapter 3: Using help system

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Display help topic by name | Get-Help -Name OR Help -Name |


####Chapter 5: Adding commands

##### 5.3 Extensions: finding and adding snap-ins
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Find a list of available snap-ins | Get-PSSnapin -registered  |
| See a list of loaded snap-ins | Get-PSSnapin |
| Load a snap-in | Add-PSSnapin name_of_the_snapin  |
| Find out which cmd-lets were added by a snap-in |  Get-Command (or alias Gmc) name_of_the_snapin  |
| Find out if the snap-in added any new PSDrive providers |  Get-PSProvider  |

##### 5.4 Extensions: finding and adding modules
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Find a list of available modules |  Get-Module -listavailable |
| See a list of loaded modules | Get-Module |
| Add a module |  Import-Module name_of_the_module  |
| Find out which commands were added by a module |  Get-Command (or alias Gmc) -module name_of_the_module  |
| Find out if the module added any new PSDrive providers |  Get-PSProvider  |

##### 5.5 Command conflict and removing extensions
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Remove a conflicting extension |   Remove-PSSnapin or Remove-Module |





























