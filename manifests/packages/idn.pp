# manage idn extension
class php::packages::idn {
  package { 'php-idn':
    ensure => installed,
    notify => Service['apache'],
  }
}
