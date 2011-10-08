class php::mod_fcgid::centos inherits php::centos {
  File['/etc/httpd/conf.d/php.conf']{
    ensure => absent,
  }
}
