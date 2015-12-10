# Testplan en -rapport: aanmaken OU's en users
* Verantwoordelijke uitvoering: Bram Martens
* Verantwoordelijke testen: Tomas Vercautter

## Testplan

Auteur(s) testplan: Bram Martens

* Na het uitvoeren van de manual moeten alle OU's aangemaakt zijn en in de correcte hiërarchie .
Dit gaan we controleren door het volgende commando: `Get-ADObject -Filter { ObjectClass -eq 'organizationalunit' }`. Uit deze lijst kan er worden afgeleidt of de naam van OU en de hiërarchie klopt.

* Ook alle gebruikers zouden moeten aangemaakt zijn en in de correcte OU geplaatst zijn. Dit kan je controleren door het volgende commando: `Get-ADUser -Filter * -SearchBase "ou=testou,dc=iammred,dc=net"`.


## testrapport

Auteurs(s) testrapport: Tomas Vercautter

* Alles stappen uit de manual werden uitgevoerd
* Alle OU's en users waren correct aangemaakt.
