# manifests/defines.pp

define php::pecl(
    $phpversion = '',
    $ensure = 'installed',
    $mode = 'package',
    $state = 'stable',
    $target_mode = 'absent'
) {
    include php::pear::common
    include php::pecl::common
    case $mode {
        package: {
            php::package{$name:
                phpversion => $phpversion,
                ensure => $ensure,
                mode => 'pecl',
            }
        }
        cli: {
            php::install{$name:
                ensure => $ensure,
                mode => 'pecl',
                state => $state,
                target_mode => $target_mode,
                require => Package['gcc'],
            }
            file{"/etc/php.d/$name.ini":
                content => "; File manged by puppet!\nextension=${name}.so",
                notify => Service['apache'],
                owner => root, group => 0, mode => 0644;
            }
        }
        default: { fail("no such mode: $mode for php::pecl") }
    }
}

define php::pear (
    $phpversion = '',
    $ensure = 'installed',
    $mode = 'package',
    $state = 'stable',
    $target_mode = 'absent'
) {
    include php::pear::common
    case $mode {
        package: {
            php::package{$name:
                phpversion => $phpversion,
                ensure => $ensure,
                mode => 'pear',
            }
        }
        cli: {
            php::install{$name:
                ensure => $ensure,
                mode => 'pear',
                state => $state,
                target_mode => $target_mode,
            }
        }
        default: { fail("no such mode: $mode for php::pecl") }
    }
}

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
    if $require {
        Package["php${phpversion}-$name"]{
            require +> $require,
        }
    }
}

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
    if $require {
        case $operatingsystem {
            centos,redhat,fedora: {
                Exec["php_${mode}_${name}"]{
                    require =>  [ Package['php'], Package['php-pear'],
                        Package['php-common'], Package['php-devel'], $require ],
                }
            }
            default: {
                Exec["php_${mode}_${name}"]{
                    require =>  [ Package['php'], Package['php-pear'],
                        Package['php-common'], $require ],
                }
            }
        }
    } else {
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
    if $notify {
        Exec["php_${mode}_${name}"]{
            notify => $notify,
        }
    }
}

