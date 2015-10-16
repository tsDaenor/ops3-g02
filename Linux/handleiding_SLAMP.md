## Handleiding: Simple LAMP stack

Deze handleiding stelt u in staat om, vertrekkende van deze repository, zelf een 'Simple LAMP stack' op te zetten.  
De VM bevat Centos 7 met Apache, MariaDb en Wordpress.  
Daarbij zal Wordpress al volledig geconfigureerd zijn met 1000 default posts.  
Deze is toegankelijk via: 192.0.3.50/wordpress

### Vereisten:

Om deze LAMP werkomgeving op te zetten, heeft u volgende software nodig:
* [Git](https://git-scm.com/downloads)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads/)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Ansible](http://docs.ansible.com/intro_installation.html)

### Installatie:

#### 1. Clonen van repository.

Open Git Bash en ga naar de gewenste directory.
Voer daarna volgend commando uit om de repository lokaal te clonen.

```ShellSession
$ git clone --config core.autocrlf=false https://github.com/HoGentTIN/ops3-g02.git
```

#### 2. De VM opstarten met Vagrant

Wanneer de repository succesvol lokaal gekloond is, kan u met Vagrant de virtuele machine opstarten.
Dit doet u met behulp van volgend commando:

```ShellSession
$ vagrant up
```

#### 3. Persoonlijke configuratie

Configuratie van de Database:

| Variable                | Required | Default     | Comments (type)                                                                                             |
| :---                    | :---     | :---        | :---                                                                                                        |
| `mariadb_databases`     | no       | []          | List of names of the databases to be added                                                                  |
| `mariadb_users`         | no       | []          | List of dicts specifying the users to be added. See below for details.                                      |
| `mariadb_root_password` | no       | ''          | The MariaDB root password. **It is highly recommended to change this!**                                     |
| `mariadb_bind_address`  | no       | '127.0.0.1' | Set this to the IP address of the network interface to listen on, or '0.0.0.0' to listen on all interfaces. |

Configuratie van de Apache webservice:

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
Configuratie van Wordpress:

| Variable             | Default     | Comments (type)                                   |
| :---                 | :---        | :---                                              |
| `wordpress_database` | 'wp_db' | The name of the database for Wordpress.           |
| `wordpress_user`     | 'wp_user' | The name of the database user.                    |
| `wordpress_password` | 'CorkIgWac' | The password of the database user.                |
| `wordpress_home_url` | '192.0.3.50/wordpress' | The home url of the wordpress application.               |
| ` wordpress_admin_user` | 'admin' | The admin user of the wordpress application.               |
| `wordpress_admin_user_pass` | 'admin' | The admin user's password.              |
| `wordpress_admin_email` | 'toon.lamberigts@gmail.com' | The email address of the admin user.               |
| `remote_wordpress_dir` | '/usr/share/wordpress' | The home directory of the wordpress application.              |
| `remote_deploy_user` | 'vagrant' | The remote user of the wordpress application.              |

