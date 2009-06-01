define php::package(
    $phpversion = '',
    $ensure = 'installed',
    $mode = 'pear'
){
    package{"php${phpversion}-$name":
        ensure => $ensure,
        require => Package['php'],
    }
    case $operatingsystem {
        centos,redhat,fedora: {
            case $mode {
                'direct': {
                    Package["php${phpversion}-$name"]{
                        name => "php${phpversion}-$name",
                    }
                }
                default: {
                    Package["php${phpversion}-$name"]{
                        name => "php${phpversion}-$mode-$name",
                    }
                }

            }
        }
    }
}
