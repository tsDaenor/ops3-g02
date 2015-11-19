# Getting Started with PowerShell 3.0 Jump Start

## 1. Don't fear the shell

Doing once in a blue moon things  -> GUI  
Business problems -> shell
 

***cmdlet***: model of composition. Really small, use pipeline to do bigger tasks. Verb - Noun  

-     *aliases*: UNIX and DOS shortcuts to the real cmdlets  
`get-alias / gal  `
-     *windows native commands*: ping, notepad, calc     
-     *Wildcards*:  
`gal g*`: all start with Get-  
`gal *sv`: all end with service  
`gal *sv, g* `(wildcards don't conflict with arrays)  
-     TAB is your friend  

  
## 2. The help system

Impossible to memorize all commands/cmdlets  
=> solution: the help system

The help command: `man` / `help` / `get-help`  
Update the help system: `update-help -Force`



**Detailed help with examples on different usages:**  
- `get-help get-service -Detailed`  
- `get-help get-service -Examples`  
- `get-help get-service -full`  
- `get-help get-service -ShowWindow`:  
 

**Parameter sets:**  
- Change the result of what the command will do.  
- Always begin with a dash  
- [] : Optional parameters  

Example:

    get-service -Name bits


**Positional parameters:**  



> get-service [[-Name] String]  

Don't have to use -Name, only use the argument  
Example:  

    get-service bits

When writing scripts, be very explanatory  
When using the console, can use shortcuts

**About topics:**  

    get-help about_*

**Categories:**  

    get-help -category 


## 3. The pipeline: getting connected & extending the shell

Pipe the results of a cmdlet to another cmdlet.  
Connects cmdlets to produce better results.  
Line continuation!  

### Exporting/importing CSV

	Get-process | export-csv c:\proc.csv  
	
	import-csv c:\proc.csv

    
### Exporting/importing XML

	Get-process | Export-Clixml c:\proc.xml
 
 	notepad
 	
 	Compare-Object -ReferenceObject (Import-Clixml c:\proc.xml) -DifferenceObject (Get-Process) -Property name

    
### Other files and printers: "out-*"

	get-service | out-file -FilePath c:\test.txt

	get-content c:\test.txt

  
### Displaying information in a GUI
 
    Get-Process | Out-GridView
    
### Making a webpage of information

	get-service | convertTo-html -Property name,status | out-file c:\test.htm

	c:\test.htm


### Cmdlets that kill:

Example:

    get-service | stop-service

* -whatif:  
  Tells you what it would do but didn't actually do it
* -confirm:  
  prompt for every action (Y/N)

Example:  
*Would stop other services that aren't bits.*

    get-service -DisplayName *bi* | stop-service -whatif

### Modules:  

Cmdlets ship in with the thing that needs to be managed -> modules  
A module contains cmdlets and providers.  

V1 & 2 = snap-ins, V3 = modules

    Get-Module -ListAvailable


## 4. Object for the Admin


### Objects in powershell 3.0:
`get-service` : returns service-objects and not just text  

* has things it has: *properties*
* things it can do: *methods*

**Example:**  
Text is hard to work with. For example finding a process with Handles > 700.  
get-process -> if it returned text then you had to cut off the first 3 lines and 7 characters of the text output.  
But in powershell: Objects!  
Each row is the object itself and each column reflects the properties

    get-process |where handles -gt 700 |sort handles

**Show all properties and methods of a cmdlet (get-member):** 

	get-service -name bits | gm 

**Select a couple of properties:**

	get-service | select -Property name, status

**Select properties and sort by properties descending:**

	get-childitem | select -Property name, length | sort -Property length -Descending

**Example with previous chapters implemented:** 

	Get-EventLog -LogName System -Newest 5 | select -Property EventID, TimeWritten, Message | sort -Property timewritten | convertTo-html | out-file c:\error.htm

### Working with XML in powershell V3:
**The dot syntax:**  

Get content and cast it as XML in the object $x:   

    $x = [xml](cat ./r_and_j.xml)

    $x.PLAY.ACT[0].SCENE[0].SPEECH

    $x = PLAY.ACT[0].SCENE[0].SPEECH |select -First 1

    $x = PLAY.ACT[0].SCENE[0].SPEECH |group speaker |sort count

**Creating a "where" filter:**  

PowerShell 2.0: 

	get-service | where {$_.status -eq "Running"}
  
- {} : filterscript  
- $_ : The current object on the pipeline  
- comparison operators: < > can't use them as they are shell redirect operators  
  `get-help *operators*`  

PowerShell 3.0:  

	get-service | where {PSItem.status -eq "Running"} 

Extend filter further:  

	get-service | where {PSItem.status -eq "Running" -and $_.name -like "b*"}


**More about where in powershell:**

1. Takes each object from the pipeline and assign to variable
2. Evaluate the code in the {}
3. if true: pass object on if false: throw it away

Simplified version of where:  
- No {}  
- No $_

> where handles -ge 1000

## 5. The Pipeline: Deeper

**Example 1:**

    get-service | stop-service  
It's gonna work but why?  

First: what type of objects are being sent across the pipeline?  

	get-service | gm

This tells us we are sending a ServiceController-object across the pipeline.

    get-help stop-service -showwindow
Check if the parameters accept pipeline input: (use -ShowWindow to find ByValue/ByPropertyName easier)   
-Name accepts pipeline input ByPropertyName, ByValue  
-InputObject accepts pipeline input ByValue  

It's gonna work with "ByValue" because both use a ServiceController that will be sent on the pipeline.

  
In this example nouns match so they're likely to work together on a pipeline  
But nouns don't always match!

**Example 2:**

    get-service | stop-process 
 
`get-help stop-process -showwindow` 

Parameters:  
Looking for things ByValue  
-InputObject Process[] IS NOT ServiceController[] so it will fail.  


Looking for things ByPropertyName  
-Name  

Is there a property that is spelled the same way as "Name"?

    get-service | gm
-> Yes: Name

So let's try:  

    get-service | stop-process -name -whatif
Mostly red because the processnames are different than the servicenames but the command will run!

**Example 3:**

I want to get all the AD computers and check the status of the bits service on them.  
Will it work?

    Get-ADComputer -filter *| get-service bits

1. `get-adcomputer | gm`  
Find out which Object we're working with if we want to use ByValue!
= ADComputer
2. `get-help get-service -showwindow`  
See if it supports ADComputer object ByValue  
Find "ByValue" -> -InputObject -> works with ServiceController object so no hookup byValue  
3.  `get-adcomputer | gm`  
Check properties of Get-ADComputer again to work with PropertyName -> "Name"  
Check ByPropertyName  
-ComputerName -> Match BUT isn't exactly spelled the same as Name  
-Name -> Match BUT it wants a service name and not a computer name  

So it won't work unless the property "Name" of Get-ADComputer is changed to "ComputerName"  

How do we do this?    
Full syntax: 

    Get-ADComputer -filter *|select -Property name, @{name='ComputerName';expression={$_.name}}
Short syntax: 

	Get-ADComputer -filter *|select -Property name, @{n='ComputerName';e={$_.name}

SOLUTION: 

	Get-ADComputer -filter *|select -Property @{n='ComputerName';e={$_.name}} | Get-Service -name bits

**LAST LINE OF RESORT: When a cmdlet doesn't support pipeline input:**  

**PowerShell 2.0:**  

    Get-ADComputer -filter * | Get-wmiObject -class win32_bios
1. `Get-ADComputer | gm`  
Check for object type to work with ByValue -> ADComputer -> Won't work  
2. `get-help get-wmiObject`  
Check for parameters that support pipeline input -> None  

How to fix it? 
 
`Get-wmiObject` takes "-Computername String[] "  
-> How to get the computernames in there from the AD?

    Get-ADComputer -filter * | select -Property name 
-> But this gives an ADComputer Object. How to extract the strings?

	Get-ADComputer -filter * | select -ExpandProperty name 
-> Returns only the Strings

SOLUTION: 

	Get-wmiObject -class win32_bios -Computername (Get-ADComputer -filter * | select -ExpandProperty name) 

**PowerShell 3.0:**  
Dot Syntax!
  
SOLUTION:

	Get-wmiObject -class win32_bios -Computername (Get-ADComputer -filter *).name 

**Script parameters**  
Script block = {}  

    Get-wmiObject -class win32_bios -Computername {$_.Name}
1. Take the value of current object on the pipeline  
2. assign this value to $_  and run the script   
3. take the value of the script and run the command with that value  

## 6. The PowerShell in the shell: remoting

*  Remoting returns objects
The objects from a very large set of machines can be manipulated
Ex. sort, format-table, ...

* Short syntax:

    icm dc,s1,s2 {//code} | sort whatever

### Universal code execution model:  
= running the code on one or different machines with one or different credentials(users) in either a secure or unsecure environment for either a long or a short time.  
Or: How PowerShell scripts can run anywhere, anytime in just the right semantics.  

### Enable remoting:  
Pre 2012 Windows Server:    
- Cmdlet: `Enable-PSRemoting`  
- Group policy  
  
Windows Server 2012: enabled by default -> cloud operating system  & it's secure

### Remote connections:  

**A one-to-one connection:**
~ a secure telnet

    New-PSSession -ComputerName dc  

short syntax: `nsn`

**A one-to-many connection:** 
Using the same command at multiple systems at the same time

    invoke-command -ComputerName dc,s1,s2 {//code}

How does it work?  
By starting a powershell session on the remote machines and running the command on them locally.  
**Serialization!**  
= Take these objects and put them in a 'property bag' (names, values, types) turn it in xml and reconstruct(deserialize) on the remote machine.

`invoke-command` -> the way powershell works! -> Universal code exection

    invoke-command {get-service -name bits} 

A deserialized object is a representation of an object, not a live object -> Only a few methods and no start, stop methods.

### Windows Powershell WebAcces: powershell through a browser  

For example:  powershell remoting on a smartphone   
Needed: Powershell V3 & WS 2012 

```Get-WindowsFeature
Windows Powershell WebAcces
Install-WindowsFeature WindowsPowerShellWebAccess
```

1. `Install-PswaWebApplication`
2. Rules: Who's allowed to use this, what are they allowed to do and on which machines?  

    Add-PswaAuthorizationRule -ConfigurationName/ ComputerName / UserName or UserGroupName

=> 3 parameters: User, Destination, Configuration

Over HTTPS, controllable and uses a jumpbox (safe environment instead of personal used box)


## 7. Getting prepared for automation

### PowerShell execution policy  
Windows doesn't load files from the current location by default  
If trusted: .\name  
Running scripts is not allowed by default  

    Get/set-ExecutionPolicy
-> 2 policies: remotesigned and allsigned  
`Set-ExecutionPolicy "allsigned"` : Everything must be signed (local and remote)  
`Set-ExecutionPolicy "remotesigned"`: Anything you download needs to be signed (remote)  

### Digitally sign a script

    dir cert:\currentuser -Recurse -CodeSigningCert -outVariable a

	$cert = $a[0]

	set-AuthenticationCodesignature -Certificate $cert -FilePath .\test.ps1

Signature block gets evaluated for runnable code!

WS 2012 R2 is remotesigned by default

### Variables in Powershell
Dollar Sign $   

    $TestVar="Hello" 
-> no cmdlets required

They take code aswell  

	$TestVar= Get-Service bits

$TestVar contains an object now (servicecontroller)   
-> Dot syntax:  
properties : `.status`   
methods: `.start()`

Example: 

    $var = read-host "Enter a name"

	write-host $var

**Don't use write-host!** -> no objects going down the pipeline -> Enemy of automation  

    Write-Output $var

Other write commands:  
- `write-warning`  
- `write-error`  

    ${ ANYTHING IN HERE } = "wow"
But no filepaths(:) as it gives conflicts

## 8. Automation in scale - Remoting

### Sessions:
	icm -ComputerName dc {$var=2}

	icm -ComputerName dc {$var}

-> No output -> Use Sessions!  

	$session=New-PSSession -ComputerName dc

	Get-PSSession

	icm -Session $sessions {$var=2}

	icm -Session $sessions {$var}

Able to open an X number of sessions and run the same code parallel on all machines.

### Getting modules from remote machines without installing them locally

	$s=New-PSSession -ComputerName dc  

	Import-PSSession -Session $s -Module ActiveDirectory   

**How does it work?**  
Got to remote machine, load the module and do get-command on all the things.  
Get that datastructure, take the information and recreate a set of scripts with exactly the same signature.  
The body of the function (dynamically generated)-> gather all that stuff up and run it over there with invoke-command.  

=> So it's like a proxy of the cmdlet on the local machine. You don't run the cmdlets on the local machine but on the remote machine.  
Full help and tab completion!  

Also possible to do this on the local machine.  
Example:

	$s = nsn //short syntax for New-PSSession
    
	Import-PSSession $s -CommandName get-process -Prefix wow
    
	Get-wowProcess

## 9. Introducing scripting and toolmaking

### Making a parameterized script
>  Script .\test.ps1:  
>  param(  
>    [string[]]$ComputerName='localhost'  
>  )  
>  //code  
 
### Script cmdlet  
Parameter attributes: mandatory, optional  
Common parameters  

>  [CmdletBinding()]  
>  param(  
>    [Parameter(Mandatory=$True)] //only affects next parameter after it  
>    [string[]]$ComputerName  
>  )  
>  //code  

### Add in help to the script
>  <#  
>  .synopsis  
>  Short explanation  
>  .Description  
>  long description  
>  .Parameter ComputerName  
>  this is for remote computers  
>  .Example  
>  Diskinfo -ComputerName remote  
>  This is for a remote computer  
>  # >  
>  [CmdletBinding()]  
>  param(  
>    [Parameter(Mandatory=$True)] //only affects next parameter after it  
>    [string[]]$ComputerName  
>  )  
>  //code  

### Cmdlet snip-its
**CTRL+J**  
Templates for cmdlets, automatically creates all the posibilities for the script  

### Give a proper name to a script
>  <#  
>  .synopsis  
>  Short explanation  
>  .Description  
>  long description  
>  .Parameter ComputerName  
>  this is for remote computers  
>  .Example  
>  Diskinfo -ComputerName remote  
>  This is for a remote computer  
>  # >  
>  function Get-DiskInfo{  
>  [CmdletBinding()]  
>  param(  
>    [Parameter(Mandatory=$True)] //only affects next parameter after it  
>    [string[]]$ComputerName  
>  )  
>  //code  
>  }  

### Making a module
**Cheaty way**  
Save as -> Diskinfo.psm1  

	Import-Module .\Diskinfo.psm1 (-Force)

**Magic paths**  
There are 2 paths in which you have to put your module in a special way to have it dynamically loaded 
 
	$env:PSModulePath -split ";"

Only put it in your own 'special' path. /WindowsPowerShell/Modules  
The folder needs to have the same name as the module you want to load  

Now it's a module => Able to add more functions to the script.
