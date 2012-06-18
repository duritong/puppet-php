class php::centos inherits php::base {
    if $php::centos_use_remo {
        include yum::remi
        Package[php]{
            require => Yum::Managed_yumrepo['remi'],
        }
    }
    if $php::centos_use_testing {
        include yum::centos::testing
        Package[php]{
            require => Yum::Managed_yumrepo['centos5-testing'],
        }
    }
    file{'/etc/httpd/conf.d/php.conf':
        source => [
            "puppet:///modules/site_php/apache/${::operatingsystem}/${::fqdn}/php.conf",
            "puppet:///modules/site_php/apache/${::operatingsystem}/php.conf",
            "puppet:///modules/php/apache/${::operatingsystem}/php.conf"
        ],
      require => [ Package[php], Package[apache] ],
      notify => Service[apache],
      owner => root, group => 0, mode => 0644;
    }
}
