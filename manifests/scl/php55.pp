# manage an scl php54 installation
class php::scl::php55 {
  require ::scl::php55
  file{'/opt/rh/php55/root/etc/php.ini':
    source  => [
      "puppet:///modules/site_php/scl_php55/${::fqdn}/php.ini",
      "puppet:///modules/site_php/scl_php55/${php::cluster_node}/php.ini",
      'puppet:///modules/site_php/scl_php55/php.ini',
      'puppet:///modules/php/config/scl_php55/php.ini'
    ],
    notify  => Service[apache],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
}
