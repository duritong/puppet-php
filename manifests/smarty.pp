class php::smarty {
    include php
    package{'php-Smarty':
        ensure => installed,
        require => Package['php'],
    }
}
