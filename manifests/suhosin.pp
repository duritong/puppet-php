# manifests/suhosin.pp
class php::suhosin {
    case $operatingsystem {
        centos: {
            if $php_centos_use_remi or $php_centos_use_testing {
                include php::suhosin::package
            }
        }
        default: {
            include php::suhosin::package
        }
    }
}
