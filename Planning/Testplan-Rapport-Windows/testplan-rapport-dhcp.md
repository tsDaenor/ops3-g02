## Testplan en -rapport: installatie dhcp

* Verantwoordelijke uitvoering: Dennis Verfaillie
* Verantwoordelijke testen: Toon Lamberigts

### Testplan

Auteur(s) testplan: Dennis Verfaillie

Na het uitvoeren van alle stappen die terug te vinden zijn in de manual van DHCP, moet het voor een client-pc mogelijk zijn om een IP-adres te verkrijgen van deze server. Nadien moeten we dan ook deze lease te zien krijgen op onze server.

- Controleren ip-adres op client: `ipconfig /all`. Het ip-adres zou 192.168.101.31 moeten zijn als dit de eerste en enige client-pc op het netwerk is.
- Voer het commando `Get-DhcpServerv4Lease -ScopeId 192.168.101.0`uit. Hier zou je een lease op naam van PFWS1.PoliForma.nl moeten zien staan.
- Voer het commando `Get-DhcpServerv4Scope`uit. Hier zou je zeker moeten zien dat er bij startrange 192.168.101.31 staat en bij endrange 192.168.101.130.


### Testrapport

Uitvoerder(s) test: Toon Lamberigts

- Alle stappen uit de manual werden uitgevoerd
- Nadat de client-pc gelinkt werd met de server kan ik zien dat hij een correct ip-adres gekregen heeft.
- Ook op de server is te zien dat er een lease op naam van PFWS1.PoliForma.nl bestaat voor ip-adres 192.168.101.31
- Na de scope te controleren zie ik dat zowel startrange als endrange correct ingesteld is.
