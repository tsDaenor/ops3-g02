# Handleiding: Monitoring server with Collectd and Graphite.

Deze handleiding stelt u in staat om, vertrekkende van deze repository, zelf een monitoring server op te zetten.  
De VM bevat Centos 7 met Apache, Mariadb, Collectd en Graphite, inclusief hun dependencies.  

Collectd zal met deze configuratie statistieken verzamelen over de **load, interfaces, cpu en memory** van de servers in het netwerk.  
Daarbij zal ook de **apache service** die draait op de LAMP stack worden gemonitord.  
Indien u andere onderdelen of services wilt monitoren, moeten er extra plugins aan collectd worden toegevoegd.  
Hiervoor zal de collectd config file moeten worden aangepast, een extra config file in de folder ´collectd_include_dir´ worden geplaatst en eventueel extra packages worden geïnstalleerd.  
Meer info over collectd plugins: [Collectd: Table of plugins](https://collectd.org/wiki/index.php/Table_of_Plugins)

De graphite pagina is toegankelijk via `192.0.3.51` en de collectd web-interface via `192.0.3.51/collectd/`  
Inloggen in het graphite dashboard kan met  `username: admin, password: admin`. 

## Vereisten:

Om deze monitoring server op te zetten, heeft u volgende software nodig:
* [Git](https://git-scm.com/downloads)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads/)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Ansible](http://docs.ansible.com/intro_installation.html)

## Installatie:

### 1. Clonen van repository.

Open Git Bash en ga naar de gewenste directory.
Voer daarna volgend commando uit om de repository lokaal te clonen.

```ShellSession
$ git clone --config core.autocrlf=input https://github.com/HoGentTIN/ops3-g02.git
```

### 2. De VM opstarten met Vagrant

Wanneer de repository succesvol lokaal gekloond is, moet u naar de map 'Linux' navigeren waarna u met Vagrant de virtuele machine kan opstarten.  
Dit doet u met behulp van volgende commando's:

```ShellSession
$ cd Linux
$ vagrant up
```
Indien u problemen ondervindt tijdens het opstarten van de VM: controleer of het bestand dat een fout geeft in UNIX-indeling staat.


Configuratie van de database
------------------

| Variable                | Required | Default     | Comments (type)                                                                                             |
| :---                    | :---     | :---        | :---                                                                                                        |
| `mariadb_databases`     | no       | []          | List of names of the databases to be added                                                                  |
| `mariadb_users`         | no       | []          | List of dicts specifying the users to be added. See below for details.                                      |
| `mariadb_root_password` | no       | ''          | The MariaDB root password. **It is highly recommended to change this!**                                     |
| `mariadb_bind_address`  | no       | '127.0.0.1' | Set this to the IP address of the network interface to listen on, or '0.0.0.0' to listen on all interfaces. |

Configuratie van de Apache webservice:
------------------

| Variable                        | Default                                    | Comments (type)                                                                       |
| :---                            | :---                                       | :---                                                                                  |
| `httpd_AccessLog_ssl`           | logs/ssl_access_log                        |                                                                                       |
| `httpd_DocumentRoot`            | '/var/www/html'                            |                                                                                       |
| `httpd_ErrorLog_ssl`            | logs/ssl_error_log                         |                                                                                       |
| `httpd_ErrorLog`                | logs/error_log                             |                                                                                       |
| `httpd_Listen_ssl`              | 443                                        |                                                                                       |
| `httpd_Listen`                  | 80                                         |                                                                                       |
| `httpd_LogLevel_ssl`            | warn                                       |                                                                                       |
| `httpd_LogLevel`                | warn                                       |                                                                                       |
| `httpd_SSLCACertificateFile`    | -                                          |                                                                                       |
| `httpd_SSLCertificateChainFile` | -                                          |                                                                                       |
| `httpd_SSLCertificateFile`      | /etc/pki/tls/certs/localhost.crt           |                                                                                       |
| `httpd_SSLCertificateKeyFile`   | /etc/pki/tls/private/localhost.key         |                                                                                       |
| `httpd_SSLCipherSuite`          | See defaults |                                                                                       |
| `httpd_SSLHonorCipherOrder`     | 'on'                                       |                                                                                       |
| `httpd_SSLProtocol`             | 'all -SSLv3 -TLSv1'                        |                                                                                       |
| `httpd_ServerAdmin`             | root@localhost                             |                                                                                       |
| `httpd_ServerRoot`              | '/etc/httpd'                               |                                                                                       |
| `httpd_ServerTokens`            | Prod                                       | See [documentation](https://httpd.apache.org/docs/current/mod/core.html#servertokens) |
| `httpd_scripting`               | -                                          | Allowed values: `php`                                                                 |

Configuratie van Collectd:
------------------

| Variable                 | Default | Comments (type)                                                                                |
| :---                     | :---    | :---                                                                                           |
| `collectd_interval`      | 10      | Sets the interval for collecting metrics, in seconds.                                          |
| `collectd_log_level`     | info    | Specifies the verbosity of logging. Values: info, notice, warning, err.                        |
| `collectd_read_threads`  | 5       | Number of threads to start for reading plugins.                                                |
| `collectd_server`        | 192.0.3.51       | **Required** The IP address of the host that will collect all generated metrics.               |
| `collectd_server_port`   | -       | Alternative port number for the collectd server (default is  25826 over UDP)                   |
| `collectd_timeout`       | 2       | Consider a value list "missing" when no update has been received for this number of iterations |
| `collectd_web_enabled`   | true    | Specifies whether `collectd-web` should be enabled on the server.                              |
| `collectd_write_threads` | 5       | Number of threads to start for dispatching value lists to write plugins.                       |
| `collectd_graphite_addr` | 192.0.3.51 | The IP address of the Graphite server. |
| `collectd_graphite_port` | 2003 | The port used to send data to the Graphite service. |


Configuratie van Graphite:
------------------

`defaults/main.yml`

| Variable           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| graphite_log_rendering_performance | no | logs rendering performance |
| graphite_log_cache_performance | no   | logs cache performance |
| graphite_log_metric_access| no       | log metric access
| graphite_timezone |  CET   | timezone for graphite

`vars/[Debian, RedHat].yml`

| Name           | Description      |
|----------------|------------------|
| apache_service | name of apache service |
|carbon_local_data_dir | carbon's data dir |
| packages       | package dependencies for graphite |
| carbon_service | name of carbon service |
| carbon_storage_dir | carbon storage directory |
| carbon_user | the owner of the carbon process|
| graphite_conf | graphite configuration directory |
| graphite_content_dir | where graphite static content is stored |
| graphite_index_file | path to graphtie's index file |
| graphite_log_dir | path to graphite's logs |
| graphite_python | path to graphite's python library|
| graphite_storage_dir |  path to graphite's storage dir |
| graphite_user | username of account running graphite |
| graphite_var | path to graphite's var directory |
| graphite_whishper_dir| path to graphite's whisper dir |


