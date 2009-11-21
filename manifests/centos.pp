class php::centos inherits php::base {
    if $php_centos_use_remi {
        include yum::remi
        Package[php]{
            require => Yum::Managed_yumrepo['remi'],
        }
    }
    if $php_centos_use_testing {
        include yum::centos::testing
        Package[php]{
            require => Yum::Managed_yumrepo['centos5-testing'],
        }
    }
    file{'/etc/httpd/conf.d/php.conf':
        source => [
            "puppet://$server/modules/site-php/apache/${operatingsystem}/${fqdn}/php.conf",
            "puppet://$server/modules/site-php/apache/${operatingsystem}/php.conf",
            "puppet://$server/modules/php/apache/${operatingsystem}/php.conf"
        ],
      require => [ Package[php], Package[apache] ],
      notify => Service[apache],
      owner => root, group => 0, mode => 0644;
    }
}
