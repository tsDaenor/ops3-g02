## Handleiding: Simple LAMP stack

Deze handleiding stelt u in staat om, vertrekkende van deze repository, zelf een 'Simple LAMP stack' op te zetten.
De VM bevat Centos 7 met Apache, MariaDb en Wordpress.

#### Vereisten:

Om deze LAMP werkomgeving op te zetten, heeft u volgende software nodig:
* [Git](https://git-scm.com/downloads)
* [Virtualbox + extension pack](https://www.virtualbox.org/wiki/Downloads/)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Ansible](http://docs.ansible.com/intro_installation.html)

#### Installatie:

##### 1. Clonen van repository.

Open Git Bash en ga naar de gewenste directory.
Voer daarna volgend commando uit om de repository lokaal te clonen.

```ShellSession
$ git clone --config core.autocrlf=false https://github.com/HoGentTIN/ops3-g02.git
```

##### 2. De VM opstarten met Vagrant

Wanneer de repository succesvol lokaal gekloond is, kan u met Vagrant de virtuele machine opstarten.
Dit doet u met behulp van volgend commando:

```ShellSession
$ vagrant up
```
