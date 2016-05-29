# fcgid on centos
class php::mod_fcgid::centos {
  file{'/etc/httpd/conf.d/php.conf':
    ensure  => absent,
    require => Package['php'],
    notify  => Service['apache'],
  }
}
