# manifests/devel.pp

class php::devel {
    package{'php-devel':
        ensure => installed,
        require => Package['php'],
    }
}
