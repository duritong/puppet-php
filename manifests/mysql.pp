# manifests/mysql.pp

class php::mysql {

    include php

    case $operatingsystem {
        gentoo: { info("gentoo manges php modules with useflags") }
        default: { 
            package{'php-mysql': 
                    ensure => present,
                    require => Package[php],
            } 
        }
    }
}
