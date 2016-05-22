# things we need for mod_fcgid & php
class php::mod_fcgid inherits php {
  require ::php::cli
  case $::osfamily {
    'RedHat': { include ::php::mod_fcgid::centos }
  }
}
