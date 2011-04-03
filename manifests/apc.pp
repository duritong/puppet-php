class php::apc {
  package{'php-pecl-apc':
    ensure => installed,
  }
  include perl::pcre::devel
}
