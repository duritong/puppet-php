# manage an scl phpX installation
# this should do everything you need
# for an scl installation
define php::scl::phpx(
  $etcdir           = "/opt/rh/php${name}/root/etc",
  $timezone         = 'Europe/Berlin',
  $settings         = {},
  $suhosin_cryptkey = undef,
  $suhosin_settings = {}
) {
  require "::scl::php${name}"
  file{
    "${etcdir}/php.d/timezone.ini":
      content => "date.timezone = '${timezone}'\n",
      require => Class["::scl::php${name}"],
      notify  => Service['apache'],
      seltype => 'etc_t',
      owner   => root,
      group   => 0,
      mode    => '0644';
  }
  include ::php::params
  $php_settings = deep_merge(deep_merge($php::params::security_settings,
                    $php::params::global_settings),$settings)
  $defaults = {
    path    => "${etcdir}/php.ini",
    require => Class["::scl::php${name}"],
    notify  => Service['apache'],
  }
  create_ini_settings($php_settings,$defaults)

  if $suhosin_cryptkey {
    $default_suhosin_settings = {
      'suhosin.session.cryptkey' => sha1("${suhosin_cryptkey}_session_${name}"),
      'suhosin.cookie.cryptkey'  => sha1("${suhosin_cryptkey}_cookie_${name}"),
    }
  } else {
    $default_suhosin_settings = {}
  }
  $php_suhosin_settings = merge(merge($suhosin_settings,
                                    $php::params::suhosin_default_settings),
                              $default_suhosin_settings)
  $suhosin_defaults = {
    path    => "${etcdir}/php.d/suhosin.ini",
    require => Class["::scl::php${name}"],
    notify  => Service['apache'],
  }
  create_ini_settings({'' => $php_suhosin_settings},$suhosin_defaults)
}
