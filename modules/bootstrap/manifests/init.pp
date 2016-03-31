class bootstrap {

  # silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }


  # ensure 'apt-get update' return 0 and not 100
  exec { 'apt-list-remove':
   command => 'rm -rf /var/lib/apt/lists/*'
  }
  exec { 'apt-get-clean':
    command => '/usr/bin/apt-get clean',
    require => Exec["apt-list-remove"]
  }




  # ensure local apt cache index is up to date before beginning
  #exec { 'apt-get-initial-update':
  #  command => '/usr/bin/apt-get update',
  #}
  #	
  #exec { 'apt-get-upgrade':
  #  command => '/usr/bin/apt-get upgrade -y',
  #  timeout => 0,
  #  require => Exec["apt-get-initial-update"]
  #}
  #
  #exec { 'apt-get-autoremove':
  #  command => '/usr/bin/apt-get autoremove -y',
  #  require => Exec["apt-get-upgrade"]
  #}

  # ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    require => Exec['apt-get-clean'],
    #require => Exec["apt-get-autoremove"]
  }



# create directory - php log (defined in CI - change for others)
  file {"/var/log/velocee":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
  }
  file {"/var/log/velocee/application":
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    require => File["/var/log/velocee"],
  }

# create directory - sessions (defined in CI - change for others)
  file {"/tmp/ci_sessions":
    ensure => directory,
    force => true,
	mode   => '0777',
  }



}
