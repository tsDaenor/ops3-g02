## Group policies
Requirements: je kan dit enkel aanmaken op een DC.

Group Policies (GPO) kan je koppelen aan een site, domein of een OU. Er bestaan ook local policies, deze zijn machine local. Daarmee zijn local policies ook de minst krachtige omdat ze eerst worden uitgevoerd.

### Aanmaken group policies
Maak een nieuwe GPO aan: `New-GPO <naam GPO>"`. Voor Poliforma.nl moet er een GPO 'PFGebruikersGPO' aangemaakt worden. Om te kijken of deze correct is aangemaakt voeren we het volgende commando uit: `Get-GPO "<naam GPO>"`.

Deze GPO moet gekoppeld zijn aan de OU 'PFAfdelingen'. Om te koppelen doen we het volgende: `New-GPLink "<naam GPO>" -target "ou=PFGebruikersGPO,dc=Poliforma,dc=nl"`

-
Geen idee of dit relevant is:
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
