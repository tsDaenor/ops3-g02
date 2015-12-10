## Testplan en -rapport: Shares

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: Toon Lamberigts

### Testplan

Auteur(s) testplan: Dennis Verfaillie

- Maak de nieuwe partitie aan op je C:-schijf, controleer dit met het commando `Get-Partition`
- Maak de nieuwe mappen aan op de nieuwe F:-schijf, controleer dit door op F: het commando `ls` uit te voeren
- Maak de shares aan, nadien zou je deze moeten terugvinden op de client-pc wanneer je je aanmeld als Administrator. Je kant dit ook testen door het commando `net view \\PFSV1` uit te voeren


### Testrapport

Uitvoerder(s) test: Toon Lamberigts

- Alle commando's slaagden zonder problemen
- Nadat ik de partitie aanmaakte kon ik deze ook terugvinden
- Ik kon de gesharede mappen zowel zien op de client-pc als wanneer ik het bovenstaande commando uitvoerde

