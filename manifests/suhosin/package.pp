class php::suhosin::package {
    package{'php-suhosin':
        ensure => installed,
        require => Package['php'],
    }
}
