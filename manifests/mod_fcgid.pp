# things we need for mod_fcgid & php
class php::mod_fcgid inherits php {
  require ::php::cli
  case $facts['os']['family'] {
    'RedHat': { include ::php::mod_fcgid::centos }
  }
}
