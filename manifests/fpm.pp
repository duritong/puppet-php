# manage a php fpm instance
define php::fpm(
  Optional[Pattern[/\Aphp\d+\Z/]] $php_inst_class  = undef,
  Enum['present','absent']        $ensure          = 'present',
  Stdlib::Compat::Absolute_Path   $workdir         = "/var/www/vhosts/${name}",
  Stdlib::Compat::Absolute_Path   $logdir          = "/var/www/vhosts/${name}/logs",
  Stdlib::Compat::Absolute_Path   $tmpdir          = "/var/www/vhosts/${name}/tmp/tmp",
  Hash                            $additional_envs = {},
  Hash                            $php_settings    = {},
  String                          $run_user        = "${name}_run",
  String                          $run_group       = $name,
  String                          $scl_prefix      = '',
){

  include ::systemd::systemctl::daemon_reload
  if $php_inst_class {
    require "::php::scl::${php_inst_class}"
    $etcdir = getvar("php::scl::${php_inst_class}::etcdir")
    $basedir = getvar("php::scl::${php_inst_class}::basedir")
    $scl_name = "${scl_prefix}${php_inst_class}"
    $php_name = $php_inst_class
    $binary = "${basedir}/root/usr/sbin/php-fpm"
  } else {
    $etcdir = '/etc'
    $basedir = '/'
    $php_name = 'php'
    $binary = "/usr/sbin/php-fpm"
  }
  service{
    [ "fpm-${name}.socket",
      "fpm-${name}" ]:;
  }
  file{
    [ "${etcdir}/php-fpm.d/${name}.conf",
      "/etc/systemd/system/fpm-${name}.socket",
      "/etc/systemd/system/fpm-${name}.service",
    ]:;
  } ~> Exec['systemctl-daemon-reload']

  if $ensure == 'present' {
    File[ "${etcdir}/php-fpm.d/${name}.conf",
      "/etc/systemd/system/fpm-${name}.socket",
      "/etc/systemd/system/fpm-${name}.service"] {
        owner => root,
        group => 0,
        mode  => '0640',
    }
    File[ "${etcdir}/php-fpm.d/${name}.conf"]{
      content => template('php/fpm/conf.erb'),
    }
    File["/etc/systemd/system/fpm-${name}.socket"]{
      content => template('php/fpm/systemd-socket.erb'),
    }
    File["/etc/systemd/system/fpm-${name}.service"] {
      content => template('php/fpm/systemd-service.erb'),
    }
    Exec['systemctl-daemon-reload'] -> Service["fpm-${name}.socket"]{
      enable => false
    } -> Service["fpm-${name}"]{
      ensure => 'running',
      enable => true,
      tag    => "systemd-${php_name}-fpm"
    } -> Service<| title == 'apache' |>
  } else {
    Service["fpm-${name}"]{
      ensure => stopped,
      enable => false,
    } -> Service["fpm-${name}.socket"]{
      enable => false
    } -> File[ "${etcdir}/php-fpm.d/${name}.conf",
      "/etc/systemd/system/fpm-${name}.socket",
      "/etc/systemd/system/fpm-${name}.service"] {
      ensure => absent,
    }
  }

}
