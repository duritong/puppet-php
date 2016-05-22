# manage an scl php55 installation
class php::scl::php55(
  $timezone = 'Europe/Berlin',
) {
  require ::scl::php55
  file{
    '/opt/rh/php55/root/etc/php.ini':
      source  => [
        "puppet:///modules/site_php/scl_php55/${::fqdn}/php.ini",
        "puppet:///modules/site_php/scl_php55/${php::cluster_node}/php.ini",
        'puppet:///modules/site_php/scl_php55/php.ini',
        'puppet:///modules/php/config/scl_php55/php.ini'
      ],
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    '/opt/rh/php55/root/etc/php.d/timezone.ini':
      content => "date.timezone = '${timezone}'\n",
      require => Package['php'],
      notify  => Service['apache'],
      owner   => root,
      group   => 0,
      mode    => '0644';
  }
}
