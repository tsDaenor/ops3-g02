## Getting started with Powershell 3.0 jump start - Cheat sheet


### 1. Don't fear the shell
 
|  Gebeurtenis | Commando  |
| :---     | :--- |
| Verander map | set-location c:\ |
| Geef lijst mappen | ls |
| Wis scherm | clear |
| maak map test | md test |
| Help | help |
| Start programma op | calculator |
 
### 2. Help system

|  Gebeurtenis | Commando  |
| :---     | :--- |
| update help | update-help -Force |
| toon helppagine | get-help get-service -Online |

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


