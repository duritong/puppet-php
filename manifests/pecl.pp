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
