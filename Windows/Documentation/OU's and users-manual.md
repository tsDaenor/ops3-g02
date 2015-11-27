### Windows Server 2012 Deployment: Users en OU-manual

##### Add one user to a specified OU

Voeg paswoord toe aan een variabele  
`$pwd = Read-Host -AsSecureString`

Nu het paswoord werd toegekend aan een variabele kun je de gebruiker aanmaken 

```
New-ADUser -Name "Bill Smith" -SamAccountName "bsmith" `
  -GivenName "Bill" -Surname "Smith" `
  -DisplayName "Bill Smith" `
  -Path "OU=SDM,DC=cpandl,DC=com" `
  -Enabled $true -AccountPassword $pwd
```

Het is natuurlijk handiger om meerdere gebruikers tegelijk aan te maken. Dit kan met behulp van een csv-bestand. Ook hier moet je vooraf een paswoord aan de variabele toekennen.

```
Import-CSV -Path C:\data\userlist.csv | New-ADUser -Enabled $true -AccountPassword $pwd
```
