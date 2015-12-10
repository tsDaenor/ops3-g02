# Testplan & testrapport LAMP stack op webservers

## Testplan
#### De requirements voor de LAMP stack op webserver 1:

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
- de MariaDB gebruiker moet rechten hebben om te kunnen schrijven in de externe database (192.0.2.50) voor Wordpress
- De website moet toegankelijk zijn via HTTP
- De website moet toegankelijk zijn via HTTPS
- Het certificaat mag niet het standaard certificaat zijn
- De Wordpress site zou toegankelijk moeten zijn via http://192.0.2.53/wordpress/

#### De requirements voor de LAMP stack op webserver 2:

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
- de MariaDB gebruiker moet rechten hebben om te kunnen schrijven in de externe database (192.0.2.50) voor Wordpress
- De website moet toegankelijk zijn via HTTP
- De website moet toegankelijk zijn via HTTPS
- Het certificaat mag niet het standaard certificaat zijn
- De Wordpress site zou toegankelijk moeten zijn via http://192.0.2.54/wordpress/

#### De requirements voor de LAMP stack op webserver 3:

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
- de MariaDB gebruiker moet rechten hebben om te kunnen schrijven in de externe database (192.0.2.50) voor Wordpress
- De website moet toegankelijk zijn via HTTP
- De website moet toegankelijk zijn via HTTPS
- Het certificaat mag niet het standaard certificaat zijn
- De Wordpress site zou toegankelijk moeten zijn via http://192.0.2.55/wordpress/

## Testrapport
#### De uitvoer van het testscript op webserver 1:

```
 ✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The MariaDB service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Firewall: interface enp0s8 should be added to the public zone
 ✓ Web traffic should pass through the firewall
 ✓ The MariaDB user should have "write access" to the database
 ✓ The website should be accessible through HTTP
 ✓ The website should be accessible through HTTPS
 ✓ The certificate should not be the default one
 ✓ The Wordpress site should be visible under http://192.0.2.53/wordpress/

13 tests, 0 failures
```

#### De uitvoer van het testscript op webserver 2:

```
 ✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The MariaDB service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Firewall: interface enp0s8 should be added to the public zone
 ✓ Web traffic should pass through the firewall
 ✓ The MariaDB user should have "write access" to the database
 ✓ The website should be accessible through HTTP
 ✓ The website should be accessible through HTTPS
 ✓ The certificate should not be the default one
 ✓ The Wordpress site should be visible under http://192.0.2.54/wordpress/

13 tests, 0 failures
```

#### De uitvoer van het testscript op webserver 3:

```
 ✓ The necessary packages should be installed
 ✓ The Apache service should be running
 ✓ The Apache service should be started at boot
 ✓ The MariaDB service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ Firewall: interface enp0s8 should be added to the public zone
 ✓ Web traffic should pass through the firewall
 ✓ The MariaDB user should have "write access" to the database
 ✓ The website should be accessible through HTTP
 ✓ The website should be accessible through HTTPS
 ✓ The certificate should not be the default one
 ✓ The Wordpress site should be visible under http://192.0.2.55/wordpress/

13 tests, 0 failures
```


