#Testrapport: Opdracht Cisco


## Testrapport labo 2.3.2.3: configuring rapid pvst+, portfast and bpdu guard

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: `Toon Lamberigts`

### Testrapport

Tester: `Toon Lamberigts`

* opstelling controleren aan de hand van foto bij opgave **-> OK**
  * controleren interfaces (tabel te vinden in opgave) **-> OK**
* vlan's controleren 
  * vlan 99: management **-> OK**
  * vlan 10: users **-> OK**
* toewijzing vlan's controleren
  * S1 f0/6 en S3 f0/18: mode acces en toegewezen aan vlan 10 **-> OK**
  * alle switches f0/1 en f0/3: mode trunk met vlan 99 **-> OK**
* controleer de primary en secondary root bridge
  * primary: S2 **-> OK**
  * secondary: S1 **-> OK**
* controleer of rapid pvst geconfigureerd is op alle 2 de switches **-> OK**
* controleer de PortFast en BPDU guard configuratie op S1 en S3 
  * S1 F0/6: portfast en BPDU guard **-> OK**
  * S3 globaal PortFast en BPDU guard configureren (BPDU werkt niet globally in packettracer) **-> OK**
  
## Testrapport labo 6.2.3.8 Configuring Multiarea OSPFv2

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: `Toon Lamberigts`

### Testrapport

Tester: `Toon Lamberigts`

* opstelling controleren aan de hand van foto bij opgave **-> OK**
  * controleren interfaces (tabel te vinden in opgave) **-> OK**
* controleer de ospf routing tabbellen op alle routers
  * `show ip route ospf` **-> OK**
  * juiste tabbellen te vinden in de opgave 
* controleer de LSDB op alle routers
  * `show ip ospf database` **-> OK**
  * juiste informatie te vinden in de opgave
* controleer md5 authentication op alle seriele interfaces
  * `show running-configuration` **-> OK**

## Testrapport labo 6.2.3.9 Configuring Multiarea OSPFv3

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: `Toon Lamberigts`

### Testrapport

Tester: `Toon Lamberigts`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave) **-> OK**
* controleer de ospf routing tabbellen op alle routers
  * `show ipv6 route ospf` 
  * 3 routes op R3 waarvan 1 summerized **-> OK**
  * 3 routes op R1 waarvan 1 summerized **-> OK**
  * 4 routes op R2 waarvan 2 summerized **-> OK**
* controleer de area van de interfaces op alle routers **-> OK**
  * juiste informatie te vinden op de topology in de opgave
* controleer de neigbours met `show ipv6 ospf neigbour` **-> OK**
* met 'show ipv6 ospf' controleren:
  * router id **-> OK**
  * interfaces in juiste area (te vinden in topology) **-> OK**
  
## Testrapport labo 6.2.3.10 Troubleshooting Multiarea OSPFv2 and OSPFv3

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: `Toon Lamberigts`

### Testrapport

Tester: `Toon Lamberigts`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave) **-> OK**
* controleer de ospf routing tabbellen op alle routers
  * `show ipv6 route ospf`
  * 4 routes op R1  **-> OK**
  * 3 routes op R2 waarvan 1 summerized **-> OK**
  * 3 routes op R3 waarvan 1 summerized **-> OK**
* controleer de area van de interfaces op alle routers **-> OK**
  * juiste informatie te vinden op de topology in de opgave 
* controleer de neigbours met `show ipv6 ospf neigbour` **-> OK**
* met `show ipv6 ospf` controleren:
  * router id **-> OK**
  * interfaces in juiste area (te vinden in topology) **-> OK**
* controleer de ospf routing tabbellen op alle routers
  * `show ip route ospf` **-> OK**
  * telkens naar alle interfaces die niet direct geconnecteerd zijn **-> OK**
  * 4 routes op R1 **-> OK**
  * 5 routes op R2 waarvan 1 default route **-> OK**
  * 5 routes op R3 waarvan 1 default route **-> OK**
* ping van elke router naar niet direct geconnecteerde interface van een andere router **-> OK**

## Testrapport labo 7.2.2.5 Configuring Basic EIGRP for IPv4

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: `Toon Lamberigts`

### Testrapport

Tester: `Toon Lamberigts`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave) **-> OK**
* controleer de neighbours van de routers
  * R1: 1.1.1.1 **-> OK**
  * R2: 2.2.2.2 **-> OK**
  * R3: 3.3.3.3 **-> OK**
* controleer de topology op elke router
  * `show ip eigrp topology` **-> OK**
* controleer protocol op elke router 
  * `show ip protocols`
  * moet `eigrp 10` zijn **-> OK**
  * routing for networks moet kloppen **-> OK**
  * gigabitEthernet 0/0 moet op elke router een passive interface zijn **-> OK**
* seriele interfaces moeten juiste bandbreedte hebben
  * `show interface s0/0/x` 
  * verbinding tussen R1 en R2: 2000 Kbit/s **-> OK**
  * verbinding tussen R2 en R3: 2000 Kbit/s **-> OK**
  * verbinding tussen R1 en R3: 64 Kbit/s **-> OK**
* verifieer verbindingen
  * ping van elke pc naar de andere 2 pc's **-> OK**
  
## Testrapport labo 7.4.3.5 Configuring Basic EIGRP for IPv6

* Verantwoordelijke uitvoering: `Tomas Vercautter`
* Verantwoordelijke testen: `Toon Lamberigts`

### Testrapport

Tester: `Toon Lamberigts`

* opstelling controleren aan de hand van foto bij opgave
  * controleren interfaces (tabel te vinden in opgave) **-> OK**
* controleer de neighbours van de routers
  * R1: FE80::1 **-> OK**
  * R2: FE80::2 **-> OK**
  * R3: FE80::3 **-> OK**
* controleer de topology op elke router
  * `show ipv6 eigrp topology` **-> OK**
* controleer protocol op elke router 
  * `show ipv6 protocols`
  * router-id moet kloppen **-> OK**
  * moet `eigrp 1` zijn **-> OK**
  * alle 3 de interfaces moeten toegevoegd zijn **-> OK**
  * gigabitEthernet 0/0 moet op elke router een passive interface zijn **-> OK**
* verifieer verbindingen
  * ping van elke pc naar de andere 2 pc's **-> OK**
