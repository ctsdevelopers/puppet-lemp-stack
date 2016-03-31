class nginx {

  # install nginx
  package { "nginx":
    ensure => present,
    require => Exec["apt-get update"]
  }

  # create directory
  file {"/var/www/my-site":
    ensure => directory,
    recurse => true,
    force => true,
    require => Package["nginx"],
  }


  # remove default site
  file {'/etc/nginx/sites-enabled/default':
    ensure => absent,
    purge => true,
    force => true,
    require => Package["nginx"],
   }  

  file {'/etc/nginx/sites-available/default':
    ensure => absent,
    purge => true,
    force => true,
    require => File["/etc/nginx/sites-enabled/default"],
   }  

  

  # create nginx config from main vagrant manifests
  file { "/etc/nginx/sites-available/my-site":
    ensure => present,
    source => "/vagrant/manifests/my-site",
    require => File["/etc/nginx/sites-available/default"],
  }

  # symlink nginx site to the site-enabled directory
  file { "/etc/nginx/sites-enabled/my-site":
    ensure => link,
    target => "/etc/nginx/sites-available/my-site",
    require => File["/etc/nginx/sites-available/my-site"],
    notify => Service["nginx"],
  }

  # starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if nesessary
  service { "nginx":
    ensure => running,
    require => Package["nginx"]
  }
}
