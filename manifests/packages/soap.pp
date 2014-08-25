# manage php-soap
class php::packages::soap {
  package{'php-soap':
    ensure => installed,
    notify => Service['apache'],
  }
}
