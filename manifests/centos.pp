# centos specific php stuff
class php::centos inherits php::base {
  file{'/etc/httpd/conf.d/php.conf':
    source  => [
      "puppet:///modules/site_php/apache/${::operatingsystem}/${::fqdn}/php.conf",
      "puppet:///modules/site_php/apache/${::operatingsystem}/php.conf",
      "puppet:///modules/php/apache/${::operatingsystem}/php.conf",
    ],
    require => [ Package[php], Package[apache] ],
    notify  => Service[apache],
    owner   => root,
    group   => 0,
    mode    => '0644';
  }
}
