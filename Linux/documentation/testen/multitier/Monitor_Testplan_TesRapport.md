# Testplan & testrapport - Monitoring server & clients:

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
- De Graphite site zou toegankelijk moeten zijn via http://192.0.2.51

#### De requirements voor de monitoring clients zijn:

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

#### Monitoring server:
De uitvoer van het testscript:
```
✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The MariaDB service should be running
 ✓ The Collectd service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The Apache service should be started at boot
 ✓ The collectd service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ SELinux should be configured correctly
 ✓ Firewall: interface enp0s8 should be added to the public zone
 ✓ Web traffic should pass through the firewall
 ✓ TCP & UDP traffic should pass through the firewall
 ✓ Mariadb should have a database for Graphite
 ✓ The MariaDB user should have "write access" to the database
 ✓ The website should be accessible through HTTP
 ✓ The website should be accessible through HTTPS
 ✓ The certificate should not be the default one
 ✓ MariaDB should not have a test database
 ✓ MariaDB should not have anonymous users
 ✓ The Graphite site should be visible under http://192.0.2.51

21 tests, 0 failures
```

#### Monitoring clients (webservers + database server):
De uitvoer van het testscript:
```
 ✓ The necessary packages should be installed
 ✓ The Collectd service should be running
 ✓ The collectd service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ SELinux should be configured correctly
 ✓ Firewall: interface enp0s8 should be added to the public zone
 ✓ Web traffic should pass through the firewall
 ✓ TCP & UDP traffic should pass through the firewall

8 tests, 0 failures
```