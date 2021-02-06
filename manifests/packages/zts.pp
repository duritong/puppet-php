# zts is used on mpm workers
class php::packages::zts {
  package { 'php-zts':
    ensure => installed,
    notify => Service['apache'],
  }
}
