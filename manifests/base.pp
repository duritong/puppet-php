# setup php
class php::base {
  package { ['php','php-fpm']:
    ensure  => present,
    require => Package['apache'],
  } -> file {
    '/etc/php.d/timezone.ini':
      content => "date.timezone = '${php::timezone}'\n",
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    '/etc/php-fpm.d':
      ensure  => directory,
      purge   => true,
      recurse => true,
      force   => true,
      owner   => root,
      group   => 0,
      mode    => '0644';
  }

  $php_settings = deep_merge($php::security_settings,deep_merge($php::settings,
  $php::params::global_settings))
  $defaults = {
    path    => '/etc/php.ini',
    require => Package['php'],
    notify  => Service['apache'],
  }
  create_ini_settings($php_settings,$defaults)

  include php::extensions::common
  include php::apc
  if versioncmp($facts['os']['release']['major'],'8') < 0 {
    package { 'php-suhosin':
      ensure  => installed,
      require => Package['php'],
    }
    if $php::suhosin_cryptkey {
      $default_suhosin_settings = {
        'suhosin.session.cryptkey' => sha1("${php::suhosin_cryptkey}_session"),
        'suhosin.cookie.cryptkey'  => sha1("${php::suhosin_cryptkey}_cookie"),
      }
    } else {
      $default_suhosin_settings = {}
    }
    $suhosin_settings = merge(merge($php::suhosin_settings,
      $php::suhosin_default_settings),
    $default_suhosin_settings)
    $suhosin_defaults = {
      path    => '/etc/php.d/suhosin.ini',
      require => Package['php-suhosin'],
      notify  => Service['apache'],
    }
    create_ini_settings( { '' => $suhosin_settings },$suhosin_defaults)

    include php::extensions::pecl::opcache
  } else {
    # TODO: eventually make this opt-out
    fail('Do not use system php from EL8 on, rather use one of the SCLs')
  }
}
