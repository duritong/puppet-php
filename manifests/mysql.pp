# manifests/mysql.pp

class php::mysql {
    case $operatingsystem {
        gentoo: { info("gentoo manges php modules with useflags") }
        default: { package{'php-mysql': ensure => present } }
    }
}
