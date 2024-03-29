# a wrapper to make installing
# php packages more convenient
define php::package (
  $phpversion = undef,
  $ensure     = 'installed',
  $mode       = 'pear',
) {
  package { "php${phpversion}-${name}":
    ensure  => $ensure,
    require => Package['php'],
  }
  if $facts['os']['family'] == 'RedHat' {
    if $mode == 'direct' {
      Package["php${phpversion}-${name}"] {
        name => "php${phpversion}-${name}",
      }
    } else {
      Package["php${phpversion}-${name}"] {
        name => "php${phpversion}-${mode}-${name}",
      }
    }
  }
}
