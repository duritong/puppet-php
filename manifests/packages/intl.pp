# intl package
class php::packages::intl {
  package{'php-intl': 
    ensure => installed,
    notify => Service['apache'],
  }
}
