## Group policies aanmaken



-
Geen idee of dit relevant is.
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
