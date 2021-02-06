# manage pecl installations
define php::pecl (
  $phpversion   = undef,
  $ensure       = 'installed',
  $mode         = 'package',
  $state        = 'stable',
  $target_mode  = 'absent',
  $package_name = $name
) {
  require php::pear::common
  require php::pecl::common
  case $mode {
    'package': {
      php::package { $package_name:
        ensure     => $ensure,
        phpversion => $phpversion,
        mode       => 'pecl',
      }
    }
    'cli': {
      php::install { $name:
        ensure      => $ensure,
        mode        => 'pecl',
        state       => $state,
        target_mode => $target_mode,
      }
      file { "/etc/php.d/${name}.ini":
        content => "; File manged by puppet!\nextension=${name}.so",
        notify  => Service['apache'],
        owner   => root,
        group   => 0,
        mode    => '0644';
      }
    }
    default: { fail("no such mode: ${mode} for php::pecl") }
  }
}
