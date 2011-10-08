class php::mod_fcgi::centos inherits php::centos {
  File['/etc/httpd/conf.d/php.conf']{
    ensure => absent,
  }
}
