# manage an scl php74 installation
class php::scl::php74(
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
) inherits php::scl::params {
  $basedir  = '/opt/remi/php74'
  $etcdir   = '/etc/opt/remi/php74'
  $scl_name = 'php74'
  php::scl::phpx{'74':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_settings => false, # gone with >= php7
  } -> php::snuffleupagus::base{
    '74':
      etcdir => $etcdir,
  }
}
