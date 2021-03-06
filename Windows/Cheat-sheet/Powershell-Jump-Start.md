## Getting started with Powershell 3.0 jump start - Cheat sheet


### 1. Don't fear the shell
 
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Verander map | set-location c:\ |
| ga naar c:\ | cd\ |
| Geef lijst mappen | ls |
| Geef lijst mappen | get-childitem |
| Wis scherm | clear |
| Wis scherm | clear-host |
| maak map test | md test |
| maak map test | mkdir test |
| lijst aliasses | gal |
| lijst aliasses | get-aliasses |
| Help | help |
| Start programma op | calculator |

windows native commands ondersteunt
 
### 2. Help system

|  Gebeurtenis | Commando  |
| :---     | :--- |
| update help | update-help -Force |
| toon helppagine | get-help get-service -Online |
| help online | -Online |
| help full | -Full |
| help in different window | -ShowWindow |  

get-help scrollt naar het einde vs help/man geeft het -- more -- systeem

'*' is your friend

Handig: om te kopiëren in Powershell moet je tekst selecteren en rechts klikken, daarna op de plaats waar je wilt plakken nogmaals rechts klikken.

### 3. The pipeline: getting connected & extending the shell

| --> Connects cmdlets to produce better results. A command line can be broken into several lines to increase readability.

|  Gebeurtenis | Commando  |
| :---     | :--- |
| stop een service | stop-service -name bits |
| start een service | start-service -name bits |
| krijg info na command | -Passthru (als parameter) |
| krijg info over wat er gaat gebeuren | -whatif |
| bevestiging vragen voor uitvoeren | -confirm |

- stop en toon een service mbv pipeline: get-service -name bits | stop-service
- zoek service-informatie en exporteer naar csv bestand: get-service | export-csv -Path c:\service.csv
- zoek proces-informatie en exporteer naar xml: get-process | Export-clixml -Path c:\good.xml
- lijst met services naar html bestand converteren: get-service | ConvertTo-html -Property name,status | out-file c:\test.html

### 4. Objects for the admin

|  Gebeurtenis | Commando  |
| :---     | :--- |
| zoek een service | get-service b* |
| zoek childitem | get-childitem |
| zoek in logfiles | Get-EventLog |
| xml toekennen aan variabele | $x = [xml](cat.\r_and_j.xml) |
| opvragen uit xml | $x.PLAY.ACT[0] |
| get process | gps |

- alle processen met handles groter dan 900: get-process | where handles -gt 900 | sort handles
- Voorbeeld met properties: Get-Childitem | Select -Property name, length | sort -Property length -Descending
- Object op dit moment in de pipeline opvragen: get-service | where {$_.status = "Running"}
- gps | where {$_.handles -ge 1000}

### 5. The pipeline: deeper

|  Gebeurtenis | Commando  |
| :---     | :--- |
| geef alle computers in AD | Get-AdComputer (beveiligd) |
| idem | Get-ADComputer -filter * |
| toon BIOS info | Get-WmiObject -Class win32_bios |
| BIOS info van bepaalde pc's | Get-WmiObject -Class win32_bios -computername DC,S1,S2 |


- verander property naam naar ComputerName: Get-ADComputer -filter * | Select -Property name, @{name='ComputerName';expression={$_.name}}
- Zoek info bios met behulp van pipeline:	Get-Wmiobject -Class win32_bios -ComputerName (Get-ADComputer -filter *).name

### 6. The PowerShell in the shell: remoting

|  Gebeurtenis | Commando  |
| :---     | :--- |
| Voor WS2012: enable remoting | Enable-PSRemoting |
| open nieuwe sessie op DC | Enter-PSSession -ComputerName dc |
| krijg info over alle computers | invoke-command -ComputerName dc,s1,s2 {get-eventlog -logname system -new 3} |
| zoek enkel lokaal | invoke-command {get-service -name bits} |
| zoek features powershell | get-windowsfeature *powershell* |
| installeer feature | Install-WindowsFeature WindowsPowershellWebaccess |
| maak een webapp | Install-pswaWebApplication -UseTestCertification |
| geef iedereen alle rechten | Add-PswaAuthorizationRule * * * |
| opent powershell in browser | start iexplore https://pwa/pswa |
| toon schijven lokaal | Get-Volume |
| toon alle schijven | icm dc,s1,s2 {Get-Volume} |

### 7. Getting prepared for automation

|  Gebeurtenis | Commando  |
| :---     | :--- |
| geef alle schijven | get-psdrive |
| op schijf cert zoeken naar certificaten | dir Cert:\CurrentUser -recurse -codesigningcert -outvariable a |
| zet in variabele | $a |
| zet gegevens van $a in $cert | $cert : $a[0] |
| zoek execution policy | get-executionpolicy |
| zet execution policy naar allsigned | set-executionpolicy allsigned |
| variabele maken | $myvar="hello" |
| commando toevoegen aan var | $myvar=Get-Service bits |
| tekst opslaan in var | $var = read-host "Enter a computerName" |

### 8. Automation in scale: remoting

|  Gebeurtenis | Commando  |
| :---     | :--- |
| create powershell session | $sessions=New-PSSession -ComputerName dc |
| toon sessie | Get-PSSession |
| variabele lokaal opslaan | icm -Session $Sessions {$var=2} |
| meet hoe lang het duurt om iets uit te voeren |	measure-command {icm -computername dc {get-process}} |
| sessie op meerdere computers | $s = New-PSSession -ComputerName $servers |
| web server installeren op iedere computer | icm -session $s {install-WindowsFeature web-server} |
| module AD remote installeren | import-pssession -session $s -module activedirectory -prefix remote |
| krijg functie en commando | Get-Command get-*ADComputer |

### 9. Introducing scripting and toolmaking

|  Gebeurtenis | Commando  |
| :---     | :--- |
| informatie C-schijf | get-wmiobject win32_logicaldisk -filter "DeviceID='c:'" |
