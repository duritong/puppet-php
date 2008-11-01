# manifests/suhosin.pp

class php::suhosin {
<<<<<<< HEAD:manifests/suhosin.pp
=======
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
>>>>>>> puzzle/development:manifests/suhosin.pp
    package{'php-suhosin':
        ensure => installed,
    }
}
