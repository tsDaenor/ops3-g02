#! /usr/bin/env bats
#
# Author: Toon Lamberigts
#
# test script Monitoring client

# Variables
sut=192.0.3.51
# end of variables


# test cases
@test 'The necessary packages should be installed' {
  rpm -q collectd
  rpm -q libsemanage-python
  rpm -q collectd-apache
  rpm -q collectd-mysql
}

@test 'The Collectd service should be running' {
  systemctl status collectd.service
}
@test 'The collectd service should be started at boot' {
  systemctl is-enabled collectd.service
}

@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}

@test 'SELinux should be configured correctly' {
  getsebool -a | grep 'collectd_tcp_network_connect --> on'
}
@test 'Firewall: interface enp0s8 should be added to the public zone' {
  firewall-cmd --list-all | grep 'interfaces.*enp0s8'
}

@test 'Web traffic should pass through the firewall' {
  firewall-cmd --list-all | grep 'services.*http\b'
  firewall-cmd --list-all | grep 'services.*https\b'
}

@test 'TCP & UDP traffic should pass through the firewall' {
  firewall-cmd --list-all | grep '2003/tcp\b'
  firewall-cmd --list-all | grep '25827/udp\b'
}
