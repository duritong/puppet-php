# setup php
class php::base {
  package{'php':
    ensure  => present,
    require => Package['apache'],
  } -> file{
    '/etc/php.d/timezone.ini':
      content => "date.timezone = '${php::timezone}'\n",
      notify  => Service['apache'],
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

  package{'php-suhosin':
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
  create_ini_settings({'' => $suhosin_settings},$suhosin_defaults)

  include ::php::extensions::common

  if versioncmp($::operatingsystemmajrelease,'6') > 0 {
    include ::php::extensions::pecl::opcache
  } else {
    include ::php::apc
  }
  if versioncmp($::operatingsystemmajrelease,'5') > 0 {
    yum::repo{
      "remi-morephp":
        descr    => "Copr repo for morephp owned by remi",
        baseurl  => "https://copr-be.cloud.fedoraproject.org/results/remi/morephp/epel-${::operatingsystemmajrelease}-\$basearch/",
        gpgkey   => 'https://copr-be.cloud.fedoraproject.org/results/remi/morephp/pubkey.gpg',
        enabled  => 1,
        gpgcheck => 1,
        before   => Package['php'],
    }
  }
}
