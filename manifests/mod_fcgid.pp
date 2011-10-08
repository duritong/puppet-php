class php::mod_fcgid inherits php {
  require php::cli
  case $operatingsystem {
    centos: { include php::mod_fcgid::centos }
  }
}