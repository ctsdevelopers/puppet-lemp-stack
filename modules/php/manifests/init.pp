class php {

  # package install list
  $packages = [
    "php5",
    "php5-cli",
    "php5-mysql",
    "php5-fpm",
    "php5-curl"
    #"php-pear",
    #"php5-dev",
    #"php5-gd",
    #"php5-mcrypt",
    #"libapache2-mod-php5"
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }
}
