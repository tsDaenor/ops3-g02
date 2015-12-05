### Windows Server 2012 Deployment: Users en OU-manual

##### Creëer een nieuwe OU, PFAfdelingen

* Maak de OU aan, die beveiligd is tegen verwijdering
  `New-ADOrganizationalUnit -Name PFAfdelingen -Path "DC=PoliForma,DC=NL"`

* Maak andere OU's aan in de OU PFAfdelingen
  `New-ADOrganizationalUnit -Name (naar keuze) -Path "OU=PFAfdelingen,DC=PoliForma,DC=NL,"`

##### Voeg een gebruiker toe aan een OU

* Voeg paswoord toe aan een variabele    
  `$pwd = Read-Host -AsSecureString`  

* Nu het paswoord werd toegekend aan een variabele kun je de gebruiker aanmaken 

```
New-ADUser BillSMith -Path "OU=Directie,DC=PoliForma,DC=nl" -Enabled $true -AccountPassword $pwd
```

Het is natuurlijk handiger om meerdere gebruikers tegelijk aan te maken. Dit kan met behulp van een csv-bestand. Ook hier moet je vooraf een paswoord aan de variabele toekennen.

```
Import-CSV -Path C:\data\userlist.csv | New-ADUser -Path "OU=Directie,DC=PoliForma,DC=nl" -Enabled $true -AccountPassword $pwd
```
