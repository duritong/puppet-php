# install composer
class php::composer {
  package{'php-composer':
    ensure => installed,
  }
}
