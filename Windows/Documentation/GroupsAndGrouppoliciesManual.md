## Group policies
Requirements: je kan dit enkel aanmaken op een DC.

Group Policies (GPO) kan je koppelen aan een site, domein of een OU. Er bestaan ook local policies, deze zijn machine local. Daarmee zijn local policies ook de minst krachtige omdat ze eerst worden uitgevoerd.

Group policies worden niet alleen bij het starten en inloggen ververst. Op DC's standaard na 5 minuten en werkstations 90 min. Om dit te forceren: `gpupdate /force`. 

### Aanmaken group policies
Maak een nieuwe GPO aan: `New-GPO <naam GPO>"`. Voor Poliforma.nl moet er een GPO 'PFGebruikersGPO' aangemaakt worden. Om te kijken of deze correct is aangemaakt voeren we het volgende commando uit: `Get-GPO "<naam GPO>"`.

Deze GPO moet gekoppeld zijn aan de OU 'PFAfdelingen'. Om te koppelen doen we het volgende: `New-GPLink "PFGebruikersGPO" -target "ou=PFGebruikersGPO,dc=Poliforma,dc=nl"`

### Oplijsting van alle GPO's in het domein
`get-GPO -all`

Omdat GPO's worden overgeërfd volgens site - domain - OU. Daarom zal de GPO PFGebruikersGPO policies van hogerop overerven. Zo zal de containers 'Computer Configuration' en 'User Configuration' in de GPO zitten die elk policies bevatten. 


### Permissies instellen
get-gpprefregistryvalue -guid $gpo.id -context user -key HKEY_CURRENT_USER\Control Panel\

Zoeken naar keys: op het internet of: `cd hklm/` vervolgens `get-childitem -erroraction silentlycontinue | format-table name, Subkeycount, valuecount -autozize`

HKEY_CURRENT_USER\Control Panel\
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\


-
Geen idee of dit relevant is: (nee dus)
## Een groep aanmaken
Een voorbeeld:
```
New-ADGroup –Name 'Managers' `
            -Description 'Security Group for all Managers' `
            -DisplayName 'Managers' `
            -GroupCategory Security `
            -GroupScope Universal `
            -SAMAccountName 'Managers' `
            -PassThru 
```

## Gebruikers aan een groep toevoegen
We halen alle managers op en steken dit in een array om deze daarna toe te voegen aan de groep.
Een voorbeeld:

```
$ManagerArray = (Get-ADUser -Filter {Description -like "*Manager*" } `
                            -Properties Description).SAMAccountName
```

```
Add-ADGroupMember -Identity "Managers" -Members $ManagerArray -PassThru
```
