class mysql {

  # root mysql password (CHANGE YOUR PASS HERE)
  $mysqlpw = "root"

  # install mysql server
  package { "mysql-server":
    ensure => present,
    require => Exec["apt-get update"]
  }

  #start mysql service
  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }

  # set mysql password
  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysqlpw status",
    command => "mysqladmin -uroot password $mysqlpw",
    require => Service["mysql"],
  }

  # get mysql file
  file { "/tmp/inserts.sql":
    ensure => present,
    source => "/vagrant/manifests/inserts.sql",
    require => Exec["set-mysql-password"],
  }

  # create db schema
  exec { "set-db-schema":
    command => "mysql -u root -p$mysqlpw < /tmp/inserts.sql",
    require => File["/tmp/inserts.sql"],
  }

}
