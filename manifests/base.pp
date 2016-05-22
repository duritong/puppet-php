# setup php
class php::base {
  package{'php':
    ensure => present,
    notify => Service['apache'],
  }
  file{
    'php_ini_config':
      path    => '/etc/php.ini',
      source  => [
        "puppet:///modules/site_php/${::fqdn}/php.ini",
        "puppet:///modules/site_php/${php::cluster_node}/php.ini",
        'puppet:///modules/site_php/php.ini',
        "puppet:///modules/php/config/php.ini.${::architecture}",
        'puppet:///modules/php/config/php.ini'
      ],
      require => Package['php'],
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    '/etc/php.d/timezone.ini':
      content => "date.timezone = '${php::timezone}'\n",
      require => Package['php'],
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
  }

  include ::php::suhosin
  include ::php::extensions::common
  if versioncmp($::operatingsystemmajrelease,'6') > 0 {
    include ::php::extensions::pecl::opcache
  } else {
    include ::php::apc
  }
}
