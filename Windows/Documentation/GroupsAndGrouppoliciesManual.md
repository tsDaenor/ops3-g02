## Group policies
Requirements: je kan dit enkel aanmaken op een DC.

Group Policies (GPO) kan je koppelen aan een site, domein of een OU. Er bestaan ook local policies, deze zijn machine local. Daarmee zijn local policies ook de minst krachtige omdat ze eerst worden uitgevoerd.

Group policies worden niet alleen bij het starten en inloggen ververst. Op DC's standaard na 5 minuten en werkstations 90 min. Om dit te forceren: `gpupdate /force`. 

### Aanmaken group policies
Maak een nieuwe GPO aan: `New-GPO <naam GPO>"`. Voor Poliforma.nl moet er een GPO 'PFGebruikersGPO' aangemaakt worden. Om te kijken of deze correct is aangemaakt voeren we het volgende commando uit: `Get-GPO "<naam GPO>"`.

Deze GPO moet gekoppeld zijn aan de OU 'PFAfdelingen'. Om te koppelen doen we het volgende: `New-GPLink "PFGebruikersGPO" -target "ou=PFGebruikersGPO,dc=Poliforma,dc=nl"`

### Oplijsting van alle GPO's in het domein
`get-GPO -all`

Omdat GPO's worden overgeërfd volgens site - domain - OU zal de GPO PFGebruikersGPO policies van hogerop overerven. Zo zal de containers 'Computer Configuration' en 'User Configuration' in de GPO zitten die elk policies bevatten. 


### Permissies instellen
get-gpprefregistryvalue -guid $gpo.id -context user -key HKEY_CURRENT_USER\Control Panel\

Zoeken naar keys: op het internet of: `cd hklm/` vervolgens `get-childitem -erroraction silentlycontinue | format-table name, Subkeycount, valuecount -autozize`

HKEY_CURRENT_USER\Control Panel\
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\


-

## groepen aanmaken 

Een overzicht van het domein Poliforma.nl:

Groepsnaam | Omschrijving | Gebruikers | Locatie | manager
 --- | --- | --- | --- | ---
 Directie | Global group voor de directieleden | Madelief Smets, Henk Pell, Teus de Jong, Dick Brinckham en Jolanda Brands | OU Directie | Madelief Smets
 Verkoop | Global group voor afdeling verkoop | Henk Pell en Wiel Nouwen | OU Verkoop | Henk Pell
 Administratie | Global group voor de afdeling administratie | ??? | OU Administratie | Teus de Jong
 Automatisering | Globel group voorde afdeling automatisering | ??? | OU Automatisering | Jolanda Brands
 Staf | Global group voor de afdeling staf | Danique Voss en Loes Heijnen | OU Staf | Danique Voss
 Productie | Global group voor de afdeling productie | Dick Brinkman, Karin Visse, Herman Bommel, Peter Carprieaux en Doortje heijnen | OU Productie | Dick Brinkman
 FabricageBudel | Global group voor de onderafdeling FabricageBudel | Peter Carprieaux, Will Snellen, Niels Smets en Floris Flipse | OU FabricageBudel, nest dit in de groep Productie | Peter Carprieaux
 
 
 

Een voorbeeld:
```
New-ADGroup –Name 'Directie' `
            -Description 'Global group voor de directieleden' `
            -DisplayName 'Directie' `
            -Path "ou=Directie,ou=PFAFdelingen,dc=Poliforma,dc=nl"`
            -ManagedBy <SAMAccountName> `
            -PassThru 
            -GroupScope DomainLocal
```


## Gebruikers aan een groep toevoegen
We geven zelf een array op van alle gebruikers die toegevoegd moeten worden aan de groep

```
Add-ADGroupMember Directie

cmdlet Add-ADGroupMember at command pipeline position 1
Supply values for the following parameters:
Members[0]: Mad_Sme
Members[1]: ....
....
```
