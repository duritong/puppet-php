# manage snufleupagus baseline
define php::snuffleupagus::base (
  Stdlib::Compat::Absolute_Path $etcdir,
  Pattern[/^\d+$/] $version = $name,
) {
  include php::snuffleupagus::global
  file {
    "${etcdir}/snuffleupagus.d":
      ensure  => directory,
      purge   => true,
      recurse => true,
      force   => true,
      owner   => root,
      group   => 0,
      mode    => '0644';
    "${etcdir}/snuffleupagus.d/base.rules":
      ensure => directory,
      source => 'puppet:///modules/php/snuffleupagus/base.rules',
      owner  => root,
      group  => 0,
      mode   => '0644';
  } ~> Service<| tag == "systemd-php${name}-fpm" |>
}
