class php::mod_fcgid inherits php {
  include mod_fcgid
  case $operatingsystem {
    centos: { include php::mod_fcgi::centos }
  }
}