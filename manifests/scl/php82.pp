# manage an scl php82 installation
class php::scl::php82 (
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
) inherits php::scl::params {
  $basedir  = '/opt/remi/php82'
  $etcdir   = '/etc/opt/remi/php82'
  $scl_name = 'php82'
  php::scl::phpx { '82':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_settings => false, # gone with >= php7
  } -> php::snuffleupagus::base {
    '82':
      etcdir => $etcdir,
  }
}
