# manage an scl php72 installation
class php::scl::php72(
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
) inherits php::scl::params {
  $basedir  = '/opt/remi/php72'
  $etcdir   = '/etc/opt/remi/php72'
  $scl_name = 'php72'
  php::scl::phpx{'72':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_settings => false, # gone with >= php7
   } -> php::snuffleupagus::base{
    '72':
      etcdir => $etcdir,
  }
}
