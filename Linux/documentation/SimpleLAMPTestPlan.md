# Testplan & testrapport simple LAMP stack

## Testplan
De requirements voor de simple LAMP stack:

- De nodige packages moeten geïnstalleerd zijn
	- httpd
	- mariadb-server
	- php
	- php-mysql
- De service Apache zou moeten runnen
- De service Mariadb zou moeten runnen
- De service MariaDB zou moeten starten bij het opstarten
- De service Apache zou moeten starten bij het opstarten
- De SELinux status zou op 'enforcing' moeten staan
- De interface enp0s8 zou toegevoegd moeten zijn aan de publieke zone
- Webverkeer moet door de firewall passeren
- MariaDB moet een database hebben voor Wordpress
- de MariaDB gebruiker moet rechten hebben om te kunnen schrijven in de database voor Wordpress
- In de Wordpress database moeten er al posts zitten
- De website moet toegankelijk zijn via HTTP
- De website moet toegankelijk zijn via HTTPS
- Het certificaat mag niet het standaard certificaat zijn
- MariaDB mag geen test database hebben
- MariaDB mag geen anonieme gebruikers hebben
- De Wordpress site zou toegankelijk moeten zijn via http://192.0.3.50/wordpress/

## Testrapport
De uitvoer van het testscript:

```
 ✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The MariaDB service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Firewall: interface enp0s8 should be added to the public zone
 ✓ Web traffic should pass through the firewall
 ✓ Mariadb should have a database for Wordpress
 ✓ The MariaDB user should have "write access" to the database
 ✓ Mariadb should have data in the wordpress database
 ✓ The website should be accessible through HTTP
 ✓ The website should be accessible through HTTPS
 ✓ The certificate should not be the default one
 ✓ MariaDB should not have a test database
 ✓ MariaDB should not have anonymous users
 ✓ The Wordpress site should be visible under http://192.0.3.50/wordpress/

17 tests, 0 failures
```

De test was succesvol, er werd aan alle requirements voldaan.

