# manage an scl php56 installation
class php::scl::php56 (
  $timezone         = $php::scl::params::timezone,
  $settings         = $php::scl::params::settings,
  $suhosin_cryptkey = $php::scl::params::suhosin_cryptkey,
  $suhosin_settings = $php::scl::params::suhosin_settings,
) inherits php::scl::params {
  $basedir = '/opt/remi/php56'
  $etcdir  = '/etc/opt/remi/php56'
  $scl_name = 'php56'
  php::scl::phpx { '56':
    etcdir           => $etcdir,
    timezone         => $timezone,
    settings         => $settings,
    suhosin_cryptkey => $suhosin_cryptkey,
    suhosin_settings => $suhosin_settings,
  }
}
