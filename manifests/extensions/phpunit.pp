# manage phpunit
class php::extensions::phpunit {
  package{ 'phpunit2':
    ensure => installed,
    require => Package['php'],
  }
}
