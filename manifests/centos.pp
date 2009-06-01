class php::centos inherits php::base {
    if $php_centos_use_remi {
        include yum::remi
        Package[php]{
            require => Yum::Managed_yumrepo['remi'],
        }
    }

    file{'/etc/httpd/conf.d/php.conf':
        source => [
            "puppet://$server/files/php/apache/${operatingsystem}/${fqdn}/php.conf",
            "puppet://$server/files/php/apache/${operatingsystem}/php.conf",
            "puppet://$server/php/apache/${operatingsystem}/php.conf"
        ],
      require => [ Package[php], Package[apache] ],
      notify => Service[apache],
      owner => root, group => 0, mode => 0644;
    }
}
