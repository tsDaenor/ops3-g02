# Testplan en - rapport: Groups en Group Policy
* Verantwoordelijke uitvoering: Bram Martens
* Verantwoordelijke testen: Toon Lamberigts

## Testplan

Auteur(s) testplan: Bram Martens

* De group policy PFGebruikers moet aangemaakt zijn. Dit kan je controleren door `Get-GPO -all`, de GPO PFGebruikers zou zich in de lijst moeten bevinden. Ook kan je zien of de GPO op de correcte locatie is aangemaakt.
* Om te controleren of de de gebruikers van een bepaalde groep allemaal correct zijn aangemaakt kan je het volgende commando uitvoeren: `Get-ADGroupMember -identity "GROUPNAME" -Recursive | Get-ADUser -Property DisplayName | Select Name,ObjectClass,DisplayName﻿`.

## Testrapport

* De group policy is correct aangemaakt.
* De gebruikers zijn in de correcte groep aangemaakt.


