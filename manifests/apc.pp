# manage apc package
class php::apc {
  package { 'php-pecl-apcu':
    ensure => installed,
  }
  $settings_path = '/etc/php.d/apcu.ini'
  php::apc::settings { $settings_path: }
}
