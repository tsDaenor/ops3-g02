# Testplan & testrapport Database Server

## Testplan
De requirements voor de database server:

- De nodige packages moeten geïnstalleerd zijn
	- mariadb-server
- De service Mariadb zou moeten runnen
- De service MariaDB zou moeten starten bij het opstarten
- De SELinux status zou op 'enforcing' moeten staan
- SELinux moet juist geconfigureerd zijn (httpd_can_network_connect_db)
- MariaDB moet een database hebben voor Wordpress
- In de Wordpress database moeten er al posts zitten
- MariaDB mag geen test database hebben
- MariaDB mag geen anonieme gebruikers hebben


## Testrapport
De uitvoer van het testscript:

```
 ✓ The necessary packages should be installed
 ✓ The MariaDB service should be running
 ✓ The MariaDB service should be started at boot
 ✓ The SELinux status should be ‘enforcing’
 ✓ SELinux should be configured correctly
 ✓ Mariadb should have a database for Wordpress
 ✓ Mariadb should have data in the wordpress database
 ✓ MariaDB should not have a test database
 ✓ MariaDB should not have anonymous users

9 tests, 0 failures
```



