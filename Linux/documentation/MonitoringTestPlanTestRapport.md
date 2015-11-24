# Testplan & testrapport - Monitoring server & client:

## Testplan
#### De requirements voor de monitoring server zijn:

- De nodige packages moeten geïnstalleerd zijn
	- httpd
  - mariadb
	- mariadb-server
  - MYSQL-python
	- php
  - collectd
  - libsemanage-python
  - collectd-apache
  - collectd-mysql
  - graphite-web
  - python-carbon
  - python-yaml
  - libselinux-python
  - libsemanage-python
- De service Apache zou moeten runnen
- De service Mariadb zou moeten runnen
- De service collectd zou moeten runnen
- De service MariaDB zou moeten starten bij het opstarten
- De service Apache zou moeten starten bij het opstarten
- De service collectd zou moeten starten bij het opstarten
- De SELinux status zou op 'enforcing' moeten staan
- SELinux moet correct geconfigureerd zijn.
- De interface enp0s8 zou toegevoegd moeten zijn aan de publieke zone
- Webverkeer moet door de firewall passeren
- TCP & UDP verkeer moet door de firewall passeren.
- MariaDB moet een database hebben voor Graphite
- de MariaDB gebruiker moet rechten hebben om te kunnen schrijven in de database voor Graphite
- De website moet toegankelijk zijn via HTTP
- De website moet toegankelijk zijn via HTTPS
- Het certificaat mag niet het standaard certificaat zijn
- MariaDB mag geen test database hebben
- MariaDB mag geen anonieme gebruikers hebben
- De Graphite site zou toegankelijk moeten zijn via http://192.0.3.51

#### De requirements voor de monitoring client zijn:

- De nodige packages moeten geïnstalleerd zijn
  - collectd
  - libsemanage-python
  - collectd-apache
  - collectd-mysql
- De service collectd zou moeten runnen
- De service collectd zou moeten starten bij het opstarten
- De SELinux status zou op 'enforcing' moeten staan
- SELinux moet correct geconfigureerd zijn.
- De interface enp0s8 zou toegevoegd moeten zijn aan de publieke zone
- Webverkeer moet door de firewall passeren
- TCP & UDP verkeer moet door de firewall passeren.


## Testrapport


