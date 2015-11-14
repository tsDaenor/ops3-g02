## Testplan labo 2.3.2.3: configuring rapid pvst+, portfast and bpdu guard

* Verantwoordelijke uitvoering: 'Tomas Vercautter'
* Verantwoordelijke testen: NAAM

### Testplan

Auteur(s) testplan:'Tomas Vercautter'

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