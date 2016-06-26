# manage apc package
class php::apc {
  if versioncmp($::operatingsystemmajrelease,'5') > 0 {
    package{'php-pecl-apcu':
      ensure => installed,
    }
  } else {
    package{'php-pecl-apc':
      ensure => installed,
    }
  }
}
