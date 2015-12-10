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

##### 5.7 Playing with Server Manager via command line!
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Display which features and roles are installed and available to install |   get-windowsfeature |
| Add a windows feature |   Add-WindowsFeature |

##### 5.8 Profile scripts: preloading extensions when the shell start
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Create a console file to export the loaded snap-ins |   Export-Console c:\myshell.psc |

#### Chapter 6: Objects: just data by another name

##### 6.3 Discovering objects: Get-Member
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Display all properties and methods of an object |  `Get-Process | Get-Member` |

##### 6.6 Sorting Objects
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Sort an object on a property (ex.VM)|  `Get-Process | Sort-Object -property VM` |
| Sort an object on a property descending (short syntax) |  `Get-Process | Sort VM -desc` |

##### 6.7 Selecting the properties you want
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Select a property of an object (long syntax) |  `Get-Process | Select-Object -property Name, ID, VM` |
| Select a property of an object (short syntax) |  `Get-Process | Select Name, ID, VM` |

#### Chapter 7: The pipeline, deeper

##### 7.5 Creating new AD users, fast and easy
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Load a CSV file into the shell |  `Import-CSV users.csv` |
| Load a CSV file into the shell and create ADUsers based on this file  |  `Import-CSV users.csv | New-ADUser` |

##### 7.7 Extracting the value from a single property
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Extract a computername from a list of computers to be fed to the parameter -computername |  `Get-Service -computername (get-adcomputer -filter * | Select-Object -expand name)` |

#### Chapter 8: Formatting-and why it's done on the right

##### 8.3 Formatting tables

* Make the shell try to size each column to hold its contents, and no more: `-autoSize`
* List of properties to be included in the table: `-property`
* Generate new set of column headers based on specified property: `-groupBy`
* Enable the shell to wrap information (instead of truncate): `-wrap`

##### 8.4 Formatting lists
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Alternativly display properties of an object in a list with the values |  `Get-Service | Format-List *` |


##### 8.5 Formatting wide
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Alternativly display properties of an object in a wide list with the values |  `Get-Process | Format-Wide name -col 4` |


##### 8.6 Custom columns and list entries
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Create a table with custom columns |  `Get-Service | Format-Table @{l='ServiceName';e={$_.Name}},Status,DisplayName` |

#### Chapter 9: Filtering and comparisons

##### 9.3 Comparison operators

* `-eq`: Equality, as in 5 -eq 5 (which is True) or "hello" -eq "help" (which is False)
* `-ne`: Not equal to, as in 10 -ne 5 (which is True) or "help" -ne "help" (which is False, because they are, in fact, equal, and we were testing to see if they were inequal)
* `-ge and -le`: Greater than or equal to, and less than or equal to, as in 10 -ge 5 (True) or Get-Date -le '2012-12-02' (which will depend on when you run this, and shows how dates can be compared in this fashion)
* `-gt and -lt`: Greater than and less than, as in 10 -lt 10 (False) or 100 -gt 10 (True)
* `(5 -gt 10) -and (10 -gt 100)` is False, because one or both subexpressions were False.
* `(5 -gt 10) -or (10 -lt 100)` is True, because at least one subexpression was True.
* `-like` accepts * as a wildcard, so you can compare to see if `"Hello" -like "*ll*"` (that would be True). `-notlike` is the reverse, and both are caseinsensitive; use `-clike` and `-cnotlike` for case-sensitive comparisons
* `-match` makes a comparison between a string of text and a regular expression pattern. `-notmatch` is its logical opposite, and as you might expect, `-cmatch` and `-cnotmatch` provide case-sensitive versions. Regular expressions are beyond the scope of what we’ll cover in this book.

##### 9.4 Filtering objects out of the pipeline
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Get services filtered on running services |  `Get-Service | Where { $_.Status -eq 'Running' }` |






























