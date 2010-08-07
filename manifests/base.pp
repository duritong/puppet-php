class php::base {
    package{php:
        ensure => present,
        notify => Service[apache],
    }
    file{php_ini_config:
        path => '/etc/php.ini',
        source => [
          "puppet:///modules/site-php/${fqdn}/php.ini",
          "puppet:///modules/site-php/php.ini",
          "puppet:///modules/php/config/php.ini.${architecture}",
          "puppet:///modules/php/config/php.ini"
      ],
      require => [ Package[php], Package[apache] ],
      notify => Service[apache],
      owner => root, group => 0, mode => 0644;
    }

    include php::suhosin
    include php::apc
    include php::extensions::common
}
