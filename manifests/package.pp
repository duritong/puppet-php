# a wrapper to make installing
# php packages more convenient
define php::package(
  $phpversion = '',
  $ensure     = 'installed',
  $mode       = 'pear',
){
  package{"php${phpversion}-${name}":
    ensure  => $ensure,
    require => Package['php'],
  }
  if $::osfamily == 'RedHat' {
    if $mode == 'direct' {
      Package["php${phpversion}-${name}"]{
        name => "php${phpversion}-${name}",
      }
    } else {
      Package["php${phpversion}-${name}"]{
        name => "php${phpversion}-${mode}-${name}",
      }
    }
  }
}
