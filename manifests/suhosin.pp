# manifests/suhosin.pp
class php::suhosin {
    case $::operatingsystem {
        centos: {
            include php::params
            if $php::params::centos_use_remi or $php::params::centos_use_testing {
                include php::suhosin::package
            }
        }
        default: {
            include php::suhosin::package
        }
    }
}
