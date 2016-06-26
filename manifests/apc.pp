# manage apc package
class php::apc {
  if versioncmp($::operatingsystemmajrelease,'5') > 0 {
    package{'php-pecl-apcu':
      ensure => installed,
    }
    $settings_path = '/etc/php.d/apcu.ini'
  } else {
    package{'php-pecl-apc':
      ensure => installed,
    }
    $settings_path = '/etc/php.d/apc.ini'
  }
  php::apc::settings{$settings_path: }
}
