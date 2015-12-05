### Shares manual

* De nodige modules hiervoor installeren, gebruik de volgende commando's die  de nodige modules zullen installeren: `Import-Module SmbShare` en `Import-Module SmbWitness`
* Zien welke shares er zich op het systeem bevinden: `Get-SmbShare`

#### Een share toevoegen
Om een nieuwe share wordt er gebruik gemaakt van het commando `New-SMBShare`. Er worden 2 shares aangemaakt: UsersFolders en UserProfiles.

```
New-SMBShare –Name “UserFolders” –Path “F:\UserFolders” `
 –ContinuouslyAvailable `
 –FullAccess Poliforma.nl\Administrator  `
 -Description "Share voor de Home folders van de gebruikers"
 ```
 
 ```
 New-SMBShare –Name “UserProfiles” –Path “F:\UserProfiles” `
 –ContinuouslyAvailable `
 –FullAccess Poliforma.nl\Administrator
 -Description "Share voor de Profile folders van de gebruikers"
 ```
 
 Er zijn nog andere parameters die van pas kunnen komen als u nog andere shares wilt aanmaken:
 
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

