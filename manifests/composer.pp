# install composer
class php::composer {
  package{'composer':
    ensure => installed,
  }
}
