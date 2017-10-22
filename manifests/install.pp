# manage manual installing of
# certain extensions.
# This is here for legacy reasons and our
# main way of installing extensions should be
# through packages.
define php::install(
  $ensure      = 'installed',
  $mode        = 'pecl',
  $state       = 'stable',
  $target_mode = 'absent'
){
  require ::php::pear::common::cli
  case $facts['os']['family'] {
    'RedHat': {
      # this is here as a blocker to enforce common best practices
      if versioncmp($::operatingsystemmajrelease,'6') > 0 {
        fail("The direct install method for php package ${name} is not anymore supported on versions higher than EL6! Use packages instead!")
      }
      require ::php::devel
    }
  }

  case $ensure {
    'installed','present': {
      $ensure_str = 'install -a'
      case $state {
        beta: { $post_cli_str = "-beta" }
      }
    }
    'absent': { $ensure_str = 'uninstall' }
    default: { fail("no such ensure: ${ensure} for php::install") }
  }

  case $target_mode {
    'absent': { $real_target_mode = $mode }
    default: { $real_target_mode = $target_mode }
  }

  $cli_part = "${ensure_str} ${name}"

  case $mode {
    'pecl': {
      $cli_str = "pecl ${cli_part}"
    }
    'pear': {
      $cli_str = "pear ${cli_part}"
    }
    default: { fail("no such method: ${method} for php::install") }
  }

  exec{"php_${mode}_${name}":
    command => "${cli_str}${post_cli_str}",
    notify  => Service['apache'],
  }
  case $ensure {
    'installed','present': {
      Exec["php_${mode}_${name}"]{
        unless => "${real_target_mode} list | egrep -qi \"^${name} \""
      }
    }
    'absent': {
      Exec["php_${mode}_${name}"]{
        onlyif => "${real_target_mode} list | egrep -qi \"^${name} \""
      }
    }
    default: { fail("no such ensure: ${ensure} for php::install") }
  }
  case $facts['os']['family'] {
    'RedHat': {
      Exec["php_${mode}_${name}"]{
        require => [ Package['php'], Package['php-common'] ],
      }
    }
    default: {
      Exec["php_${mode}_${name}"]{
        require =>  [ Package['php'], Package['php-common'] ],
      }
    }
  }
}
