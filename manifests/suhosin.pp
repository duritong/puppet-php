# manage suhosin package
class php::suhosin {
  package{'php-suhosin':
    ensure => installed,
  }
}
