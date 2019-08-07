# manage a php fpm instance
define php::fpm(
  Optional[Pattern[/\Aphp\d+\Z/]] $php_inst_class  = undef,
  Enum['present','absent']        $ensure          = 'present',
  Stdlib::Compat::Absolute_Path   $workdir         = "/var/www/vhosts/${name}",
  Stdlib::Compat::Absolute_Path   $logdir          = "/var/www/vhosts/${name}/logs",
  Stdlib::Compat::Absolute_Path   $tmpdir          = "/var/www/vhosts/${name}/tmp/tmp",
  Hash                            $additional_envs = {},
  Hash                            $php_settings    = {},
  Hash                            $fpm_settings    = {},
  Hash                            $systemd_options = {},
  String                          $run_user        = "${name}_run",
  String                          $run_group       = $name,
  Array[Stdlib::Compat::Absolute_Path]
                                  $writable_dirs   = [],
){

  include ::systemd::systemctl::daemon_reload
  include ::php::disable_mod_php
  if $php_inst_class {
    require "::php::scl::${php_inst_class}"
    $etcdir = getvar("php::scl::${php_inst_class}::etcdir")
    $basedir = getvar("php::scl::${php_inst_class}::basedir")
    $scl_name = getvar("php::scl::${php_inst_class}::scl_name")
    $php_name = $php_inst_class
    $binary = "${basedir}/root/usr/sbin/php-fpm"
  } else {
    $etcdir = '/etc'
    $basedir = '/'
    $scl_name = false
    $php_name = 'php'
    $binary = '/usr/sbin/php-fpm'
  }
  service{
    [ "fpm-${name}.socket",
      "fpm-${name}" ]:;
  } -> logrotate::rule{
    "fpm-error-logs-${name}":
      path         => "${logdir}/fpm-error.log",
      compress     => true,
      copytruncate => true,
      dateext      => true,
      su           => true,
      su_user      => $run_user,
      su_group     => $run_group,
  }
  file{
    [ "${etcdir}/php-fpm.d/${name}.conf",
      "/etc/systemd/system/fpm-${name}.socket",
      "/etc/systemd/system/fpm-${name}.service",
    ]:
      owner => root,
      mode  => '0640',
  } ~> Exec['systemctl-daemon-reload']

  if $ensure == 'present' {
    include ::php::fpm::base
    $real_fpm_settings = $php::fpm::base::settings + $fpm_settings
    File[ "${etcdir}/php-fpm.d/${name}.conf"]{
      group => $run_group,
    }
    File["/etc/systemd/system/fpm-${name}.socket",
      "/etc/systemd/system/fpm-${name}.service"]{
        group => 0,
    }
    File[ "${etcdir}/php-fpm.d/${name}.conf"]{
      content => template('php/fpm/conf.erb'),
    }
    File["/etc/systemd/system/fpm-${name}.socket"]{
      content => template('php/fpm/systemd-socket.erb'),
      notify  => Service["fpm-${name}.socket"],
    }
    File["/etc/systemd/system/fpm-${name}.service"] {
      content => template('php/fpm/systemd-service.erb'),
      notify  => Service["fpm-${name}"],
    }
    Exec['systemctl-daemon-reload'] -> Service["fpm-${name}.socket"]{
      ensure => 'running',
      enable => true,
    } ~> Service["fpm-${name}"]{
      tag    => "systemd-${php_name}-fpm"
    } -> Service<| title == 'apache' |>
  } else {
    Logrotate::Rule["fpm-error-logs-${name}"]{
      ensure => absent,
    }
    Service["fpm-${name}"]{
      ensure => stopped,
      enable => false,
    } -> Service["fpm-${name}.socket"]{
      ensure => stopped,
      enable => false
    } -> File[ "${etcdir}/php-fpm.d/${name}.conf",
      "/etc/systemd/system/fpm-${name}.socket",
      "/etc/systemd/system/fpm-${name}.service"] {
      ensure => absent,
    }
  }
}
