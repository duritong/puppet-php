# manifests/packages/idn.pp

class php::packages::idn {
    package{'php-idn': 
        ensure => installed,
        notify => Service['apache'],
    }
}
