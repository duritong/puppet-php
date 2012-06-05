class php::devel {
  package{"php-devel.${::architecture}":
    ensure => installed,
    require => Package['php'],
  }
}
