# manifests/pgsql.pp

class php::pgsql {
    case $operatingsystem {
        gentoo: { info("gentoo manges php modules with useflags") }
        default: { package{'php-pgsql': ensure => present } }
    }
}
