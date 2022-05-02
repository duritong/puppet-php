# manage an scl php81 installation
class php::scl::php81 (
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
) inherits php::scl::params {
  $basedir  = '/opt/remi/php81'
  $etcdir   = '/etc/opt/remi/php81'
  $scl_name = 'php81'
  php::scl::phpx { '81':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_settings => false, # gone with >= php7
  } -> php::snuffleupagus::base {
    '81':
      etcdir => $etcdir,
  }
}
