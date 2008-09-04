# manifests/suhosin.pp

class php::suhosin {
    package{'php-suhosin':
        ensure => installed,
    }
}
