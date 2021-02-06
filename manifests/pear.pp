# manage pear installations
define php::pear (
  $phpversion  = undef,
  $ensure      = 'installed',
  $mode        = 'package',
  $state       = 'stable',
  $target_mode = 'absent'
) {
  require php::pear::common
  case $mode {
    'package': {
      php::package { $name:
        ensure     => $ensure,
        phpversion => $phpversion,
        mode       => 'pear',
      }
    }
    'cli': {
      php::install { $name:
        ensure      => $ensure,
        mode        => 'pear',
        state       => $state,
        target_mode => $target_mode,
      }
    }
    default: { fail("no such mode: ${mode} for php::pear") }
  }
}
