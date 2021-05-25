# manage an scl php80 installation
class php::scl::php80 (
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
) inherits php::scl::params {
  $basedir  = '/opt/remi/php80'
  $etcdir   = '/etc/opt/remi/php80'
  $scl_name = 'php80'
  php::scl::phpx { '80':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_settings => false, # gone with >= php7
  } -> php::snuffleupagus::base {
    '80':
      etcdir => $etcdir,
  }
}
