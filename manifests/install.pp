define php::install(
    $ensure = 'installed',
    $mode = 'pecl',
    $state = 'stable',
    $target_mode = 'absent'
){
    include php::pear::common::cli
    case $operatingsystem {
        centos,redhat: {
            include php::devel
        }
    }

    case $ensure {
        installed,present: {
            $ensure_str = 'install -a'
            case $state {
                beta: { $post_cli_str = "-beta" }
            }
        }
        absent: { $ensure_str = 'uninstall' }
        default: { fail("no such ensure: $ensure for php::install") }
    }

    case $target_mode {
        'absent': { $real_target_mode = $mode }
        default: { $real_target_mode = $target_mode }
    }

    $cli_part = "$ensure_str $name"

    case $mode {
        'pecl': {
            $cli_str = "pecl $cli_part"
        }
        'pear': {
            $cli_str = "pear $cli_part"
        }
        default: { fail("no such method: $method for php::install") }
    }

    exec{"php_${mode}_${name}":
        command => "${cli_str}${post_clit_str}",
        notify => Service['apache'],
    }
    case $ensure {
        installed,present: {
            Exec["php_${mode}_${name}"]{
                unless => "$real_target_mode list | egrep -qi \"^$name \""
            }
        }
        absent: {
            Exec["php_${mode}_${name}"]{
                onlyif => "$real_target_mode list | egrep -qi \"^$name \""
            }
        }
        default: { fail("no such ensure: $ensure for php::install") }
    }
    case $operatingsystem {
        centos,redhat,fedora: {
            Exec["php_${mode}_${name}"]{
                require =>  [ Package['php'], Package['php-pear'],
                    Package['php-common'], Package['php-devel'] ],
            }
        }
        default: {
            Exec["php_${mode}_${name}"]{
                require =>  [ Package['php'], Package['php-pear'],
                    Package['php-common'] ],
            }
        }
    }
}
