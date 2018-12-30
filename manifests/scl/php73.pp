# manage an scl php73 installation
class php::scl::php73(
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
) inherits php::scl::params {
  $basedir  = '/opt/remi/php73'
  $etcdir   = '/etc/opt/remi/php73'
  $scl_name = 'php73'
  php::scl::phpx{'73':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_settings => false, # gone with >= php7
  } -> php::snuffleupagus::base{
    '73':
      etcdir => $etcdir,
  }
}
