# manifests/suhosin.pp

class php::suhosin {
    case $operatingsystem {
        centos: {
            if $php_centos_use_remi {
                include php::suhosin::package
            }
        }
        default: {
            include php::suhosin::package
        }
    }
}

class php::suhosin::package {
    package{'php-suhosin':
        ensure => installed,
        require => Package['php'],
    }
}
