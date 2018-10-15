# manage an scl php55 installation
class php::scl::php54(
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
  $suhosin_cryptkey = $php::scl::params::suhosin_cryptkey,
  $suhosin_settings = $php::scl::params::suhosin_settings,
) inherits php::scl::params {
  $basedir = '/opt/rh/php54'
  $etcdir  = "${basedir}/root/etc"
  $scl_name = 'php54'
  php::scl::phpx{'54':
    etcdir            => $etcdir,
    timezone          => $timezone,
    settings          => $settings,
    suhosin_cryptkey  => $suhosin_cryptkey,
    suhosin_settings  => $suhosin_settings,
    apc_config_preifx => '',
  }
}
