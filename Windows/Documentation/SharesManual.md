### Shares manual

* De nodige modules hiervoor installeren, gebruik de volgende commando's die  de nodige modules zullen installeren: `Import-Module SmbShare` en `Import-Module SmbWitness`
* Zien welke shares er zich op het systeem bevinden: `Get-SmbShare`

#### Een nieuwe partitie aanmaken
Voor we aan de slag kunnen gaan en een share maken, willen we ervoor zorgen dat deze op een andere partitie op onze server staat. We kiezen hier voor de F: schijf.

Voor eerst het commando `Get-Disk` uit om te weten van welke schrijf je een nieuwe partitie wil aanmaken

```
New-Partition -DiskNumber 0 -AssignDriverLetter -Size 5GB
Format-Volume -DriveLetter E -FileSystem NTFS
Set-Volume -DriveLetter E -NewFileSystemLabel "PFSV1Data"
Set-Partition -DriveLetter E -NewDriveLetter F
```

#### Een share toevoegen
Om een nieuwe share wordt er gebruik gemaakt van het commando `New-SMBShare`. Er worden 2 shares aangemaakt: UsersFolders en UserProfiles.

```
New-SMBShare –Name UserFolders –Path F:\UserFolders `
 –FullAccess PoliForma.nl\Administrator  
 ```
 
 ```
 New-SMBShare –Name UserProfiles –Path F:\UserProfiles `
 –FullAccess Poliforma.nl\Administrator
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

