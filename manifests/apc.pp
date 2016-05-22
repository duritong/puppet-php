# manage apc package
class php::apc {
  package{'php-pecl-apc':
    ensure => installed,
  }
}
