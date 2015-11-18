#### Script: Installeren Active Directory

#### Wat wordt er gedaan in dit script?

- Installatie Active Directory Domain Services
- Installatie DNS

#### Script: sla dit op als activedirectory.ps1

```
Install-WindowsFeature AD-Domain-Services, DNS – IncludeManagementTools
$SMPass = ConvertTo-SecureString 'P@$$w0rd11' –AsPlainText -Force
Install-ADDSForest -DomainName Poliforma.nl – SafeModeAdministratorPassword $SMPass –Confirm:$false
```

##### Na het installeren van de ADDS zal uw server ook opnieuw opgestart moeten worden
