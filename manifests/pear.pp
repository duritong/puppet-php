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
