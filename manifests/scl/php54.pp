# manage an scl php54 installation
class php::scl::php54(
  $timezone = 'Europe/Berlin',
) {
  require ::scl::php54
  file{
    '/opt/rh/php54/root/etc/php.ini':
      source  => [
        "puppet:///modules/site_php/scl_php54/${::fqdn}/php.ini",
        "puppet:///modules/site_php/scl_php54/${php::cluster_node}/php.ini",
        'puppet:///modules/site_php/scl_php54/php.ini',
        'puppet:///modules/php/config/scl_php54/php.ini'
      ],
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    '/opt/rh/php54/root/etc/php.d/timezone.ini':
      content => "date.timezone = '${timezone}'\n",
      require => Package['php'],
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    }
}
