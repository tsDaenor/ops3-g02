#! /usr/bin/env bats
#
# Author: Toon Lamberigts
#
# test script Database Server

# Variables
sut=192.0.2.52
mariadb_user=wp_user
mariadb_root_password=root
wordpress_database=wp_db
wordpress_user=wp_user
wordpress_password=wordpress
# end of variables


# test cases
@test 'The necessary packages should be installed' {
  rpm -q mariadb-server

}

@test 'The MariaDB service should be running' {
  systemctl status mariadb.service
}

@test 'The MariaDB service should be started at boot' {
  systemctl is-enabled mariadb.service
}

@test 'The SELinux status should be ‘enforcing’' {
  [ -n "$(sestatus) | grep 'enforcing'" ]
}
@test 'SELinux should be configured correctly' {
  getsebool -a | grep 'httpd_can_network_connect_db --> on'
}

@test 'Mariadb should have a database for Wordpress' {
  mysql -uroot -p${mariadb_root_password} --execute 'show tables' ${wordpress_database}
}


@test 'Mariadb should have data in the wordpress database' {
  mysql -uroot -p${mariadb_root_password} --execute 'SELECT * FROM wp_posts' ${wordpress_database} | grep 'post-1000'
}

@test 'MariaDB should not have a test database' {
  run mysql -uroot -p${mariadb_root_password} --execute 'show tables' test
  [ "0" -ne "${status}" ]
}

@test 'MariaDB should not have anonymous users' {
  result=$(mysql -uroot -p${mariadb_root_password} --execute "select * from user where user='';" mysql)
  [ -z "${result}" ]
}
