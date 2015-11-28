#Testplannen Opdracht Cisco


## Testplan labo 2.3.2.3: configuring rapid pvst+, portfast and bpdu guard

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:`Tomas Vercautter`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave)
* vlan's controleren 
  * vlan 99: management
  * vlan 10: users
* toewijzing vlan's controleren
  * S1 f0/6 en S3 f0/18: mode acces en toegewezen aan vlan 10
  * alle switches f0/1 en f0/3: mode trunk met vlan 99
* controleer de primary en secondary root bridge
  * primary: S2
  * secondary: S1
* controleer als rapid pvst geconfigureerd is op alle 2 de switches
* controleer de PortFast en BPDU guard configuratie op S1 en S3
  * S1 F0/6: portfast en BPDU guard
  * S3 globaal PortFast en BPDU guard configureren (BPDU werkt niet globally in packettracer)
  
## Testplan labo 6.2.3.8 Configuring Multiarea OSPFv2

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:`Tomas Vercautter`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave)
* controleer de ospf routing tabbellen op alle routers
  * `show ip route ospf`
  * juiste tabbellen te vinden in de opgave
* controleer de LSDB op alle routers
  * `show ip ospf database`
  * juiste informatie te vinden in de opgave
* controleer md5 authentication op alle seriele interfaces
  * `show running-configuration`

## Testplan labo 6.2.3.9 Configuring Multiarea OSPFv3

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:`Tomas Vercautter`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave)
* controleer de ospf routing tabbellen op alle routers
  * `show ipv6 route ospf`
  * 3 routes op R3 waarvan 1 summerized
  * 3 routes op R1 waarvan 1 summerized
  * 4 routes op R2 waarvan 2 summerized
* controleer de area van de interfaces op alle routers
  * juiste informatie te vinden op de topology in de opgave
* controleer de neigbours met `show ipv6 ospf neigbour`
* met 'show ipv6 ospf' controleren:
  * router id
  * interfaces in juiste area (te vinden in topology)
  
## Testplan labo 6.2.3.10 Troubleshooting Multiarea OSPFv2 and OSPFv3

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:`Tomas Vercautter`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave)
* controleer de ospf routing tabbellen op alle routers
  * `show ipv6 route ospf`
  * 4 routes op R1 
  * 3 routes op R2 waarvan 1 summerized
  * 3 routes op R3 waarvan 1 summerized
* controleer de area van de interfaces op alle routers
  * juiste informatie te vinden op de topology in de opgave
* controleer de neigbours met `show ipv6 ospf neigbour`
* met `show ipv6 ospf` controleren:
  * router id
  * interfaces in juiste area (te vinden in topology)
* controleer de ospf routing tabbellen op alle routers
  * `show ip route ospf`
  * telkens naar alle interfaces die niet direct geconnecteerd zijn
  * 4 routes op R1
  * 5 routes op R2 waarvan 1 default route
  * 5 routes op R3 waarvan 1 default route
* ping van elke router naar niet direct geconnecteerde interface van een andere router7

## Testplan labo 7.2.2.5 Configuring Basic EIGRP for IPv4

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:`Tomas Vercautter`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave)
* controleer de neighbours van de routers
  * R1: 1.1.1.1
  * R2: 2.2.2.2
  * R3: 3.3.3.3
* controleer de topology op elke router
  * `show ip eigrp topology`
* controleer protocol op elke router 
  * `show ip protocols`
  * moet `eigrp 10 zijn`
  * routing for networks moet kloppen
  * gigabitEthernet 0/0 moet op elke router een passive interface zijn
* seriele interfaces moeten juiste bandbreedte hebben
  * `show interface s0/0/x`
  * verbinding tussen R1 en R2: 2000 Kbit/s
  * verbinding tussen R2 en R3: 2000 Kbit/s
  * verbinding tussen R1 en R3: 64 Kbit/s
* verifieer verbindingen
  * ping van elke pc naar de andere 2 pc's
  
## Testplan labo 7.4.3.5 Configuring Basic EIGRP for IPv6

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:`Tomas Vercautter`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave)
* controleer de neighbours van de routers
  * R1: FE80::1
  * R2: FE80::2
  * R3: FE80::3
* controleer de topology op elke router
  * `show ipv6 eigrp topology`
* controleer protocol op elke router 
  * `show ipv6 protocols`
  * router-id moet kloppen
  * moet `eigrp 1` zijn
  * alle 3 de interfaces moeten toegevoegd zijn
  * gigabitEthernet 0/0 moet op elke router een passive interface zijn
* verifieer verbindingen
  * ping van elke pc naar de andere 2 pc's
