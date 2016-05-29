# manage an scl php55 installation
class php::scl::php55(
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
  $suhosin_cryptkey = $php::scl::params::suhosin_cryptkey,
  $suhosin_settings = $php::scl::params::suhosin_settings,
) inherits php::scl::params {
  $basedir = '/opt/rh/php55'
  $etcdir  = "${basedir}/root/etc"
  php::scl::phpx{'55':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_cryptkey => $suhosin_cryptkey,
    suhosin_settings => $suhosin_settings,
  }
}
