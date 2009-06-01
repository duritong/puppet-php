class php::gentoo inherits php::base {
    File[php_ini_config]{
        path => "/etc/php/apache2-php5/php.ini",
    }
    Package[php]{
        category => 'dev-lang',
    }
}
