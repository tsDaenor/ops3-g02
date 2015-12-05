### Shares manual

* De nodige modules hiervoor installeren, gebruik de volgende commando's die  de nodige modules zullen installeren: `Import-Module SmbShare` en `Import-Module SmbWitness`
* Zien welke shares er zich op het systeem bevinden: `Get-SmbShare`

#### Een share toevoegen
Om een nieuwe share toe te voegen gebruikt men het commando `New-SMBShare`. Een overzicht van de belangrijkste parameters vind je hier:

|Parameter| Beschrijving |
| --- | --- |
| Name | De naam van de share |
| Path | Het pad waar de share gemaakt moet worden |
| Description | Een beschrijving van de share |
| FullAcces | De gebruikers die volledige toegang tot de share hebben |
| NoAcces | Gebruikers die geen toegang hebben tot de share |
| ReadAcces | Gebruikers die alleen de bestanden kunnen lezen in de share |
| ChangeAccess | Gebruikers die kunnen lezen en schrijven|
| Current User Limit | Een beperking van hoeveel gebruikers de share op hetzelfde ogenblik kunnen raadplegen |
| EncryptData | De share wordt geëncrypteerd indien deze parameter op true staat (boolean) |
| ContinuouslyAvailable | Of de share beschikbaar moet zijn nadat het systeem is gereboot (boolean) |
| Temporary | De share wordt verwijderd indien het systeem opnieuw opstart als deze parameter true is (boolean) |

Een voorbeeld:
```
New-SMBShare –Name “Shared” –Path “C:\Shared” `
 –ContinuouslyAvailable `
 –FullAccess domain\admingroup  `
 -ChangeAccess domain\deptusers `
 -ReadAccess “domain\authenticated users”
 ```
 
 Voor de opdracht:
 ```
 New-SMBShare -Name "UserFolders" `
  -ContinuouslyAvailable `
  -FullAccess 
  ...
```
