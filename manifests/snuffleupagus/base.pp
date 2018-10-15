# manage snufleupagus baseline
define php::snuffleupagus::base(
  Stdlib::Compat::Absolute_Path $etcdir,
){
  file{
    "${etcdir}/snuffleupagus.d":
      ensure  => directory,
      purge   => true,
      recurse => true,
      force   => true,
      owner   => root,
      group   => 0,
      mode    => '0644';
    "${etcdir}/snuffleupagus.d/base.rules":
      source => 'puppet:///modules/php/snuffleupagus/base.rules',
      ensure  => directory,
      owner   => root,
      group   => 0,
      mode    => '0644';
  } ~> Service<| tag == "systemd-php${name}-fpm" |>
}
